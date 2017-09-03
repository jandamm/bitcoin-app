//
//  HistoryChartView.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import Foundation
import Charts

class HistoryChartView: LineChartView {

    override func awakeFromNib() {
        super.awakeFromNib()

        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("dd.MM.yy")
        let valueFormatter = HistoryChartXAxisFormatter(dateFormatter: dateFormatter)
        xAxis.valueFormatter = valueFormatter
        xAxis.labelPosition = .bottom
        drawBordersEnabled = true

        // Hide uneccessary chart
        chartDescription?.text = nil
        rightYAxisRenderer = YAxisRenderer(viewPortHandler: nil, yAxis: nil, transformer: nil)
        legend.form = .none
    }

    func setHistoryData(_ data: [BitcoinHistory]) {

        let lineChartEntries = data.map { ChartDataEntry(x: $0.time.timeIntervalSince1970, y: $0.average) }

        let line = LineChartDataSet(values: lineChartEntries, label: nil)
        line.colors = [.primary]
        line.circleColors = [.primary]
        line.circleRadius = 2
        line.circleHoleRadius = 0
        line.mode = .cubicBezier

        let chartData = LineChartData()
        chartData.addDataSet(line)

        self.data = chartData
    }
}

private class HistoryChartXAxisFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter: DateFormatter

    init(dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter

        super.init()
    }

    func stringForValue(_ value: Double, axis _: AxisBase?) -> String {
        let date = Date(timeIntervalSince1970: value)
        return dateFormatter.string(from: date)
    }
}
