//
//  ChartView.swift
//  Big5App
//
//  Created by がり on 2021/01/24.
//

import SwiftUI
import Charts


struct ChartView : UIViewRepresentable {
    var entries : [RadarChartDataEntry]
    
    // UIViewを返す。この場合はRadarChartView
    func makeUIView(context: Context) -> RadarChartView {
        let chart = RadarChartView()
        chart.data = addData()
        
        // 凡例を非表示
        chart.legend.enabled = false
        // TapGestureを無効化
        chart.highlightPerTapEnabled = false
        // チャートの回転を無効化
        chart.rotationEnabled = false
        
        // X軸を設定
        let xAxis = chart.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .bold)
        xAxis.xOffset = 5
        xAxis.yOffset = 5
        xAxis.valueFormatter = XAxisFormatter()
        
        // Y軸を設定
        let yAxis = chart.yAxis
        yAxis.axisMaximum = 4
        yAxis.axisMinimum = -4
        yAxis.drawTopYLabelEntryEnabled = false
        yAxis.drawLabelsEnabled = false
        yAxis.valueFormatter = YAxisFormatter()
        
        return chart
    }
    // チャートの入力データが変更された場合のビュー更新を行う
    func updateUIView(_ uiView: RadarChartView, context: Context) {

        // X軸を設定
        let xAxis = uiView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .bold)
        xAxis.xOffset = 5
        xAxis.yOffset = 5
        xAxis.valueFormatter = XAxisFormatter()
        
        // Y軸を設定
        let yAxis = uiView.yAxis
        yAxis.axisMaximum = 4
        yAxis.axisMinimum = -5
        yAxis.drawTopYLabelEntryEnabled = false
        yAxis.drawLabelsEnabled = false
        yAxis.valueFormatter = YAxisFormatter()
        
        uiView.data = addData()
    }
    
    func addData() -> RadarChartData {
        // データの追加処理
        let data = RadarChartData()
        let dataSet = RadarChartDataSet(entries: entries)
        data.addDataSet(dataSet)
        
        // チャートのColor設定
        let redColor = UIColor(red: 247/255, green: 67/255, blue: 115/255, alpha: 1)
        let redFillColor = UIColor(red: 247/255, green: 67/255, blue: 115/255, alpha: 0.6)
        dataSet.colors = [redColor]
        dataSet.fillColor = redFillColor
        dataSet.drawFilledEnabled = true
        
        dataSet.label = "my Data"
        return data
    }
    
    typealias UIViewType = RadarChartView
    
}

class DataSetValueFormatter: IValueFormatter {
    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        ""
    }
}

class XAxisFormatter: IAxisValueFormatter {
    
    let titles = ["協調性",
                  "外向性",
                  "開放性",
                  "誠実性",
                  "神経症的傾向"]
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        titles[Int(value) % titles.count]
    }
}

class YAxisFormatter: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        "\(Int(value))"
    }
}


struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(entries: [RadarChartDataEntry(value: 4),
                            RadarChartDataEntry(value: 1),
                            RadarChartDataEntry(value: -3),
                            RadarChartDataEntry(value: 0),
                            RadarChartDataEntry(value: 4)])
    }
}
