$: << File.join(File.absolute_path(__FILE__), '..', 'lib')

require 'pulse-meter/visualizer'

PulseMeter.redis = Redis.new

layout = PulseMeter::Visualizer.draw do |l|

  l.title "WunderZoo Stats"

  l.page "Counts" do |p|

    p.spline "Lama count", sensor: :lama_count do |c|
      c.redraw_interval 5
      c.values_label 'Count'
      c.width 5
      c.show_last_point true
      c.timespan 1200
    end

    p.area "Rhino count", sensor: :rhino_count do |c|
      c.redraw_interval 5
      c.values_label 'Count'
      c.width 5
      c.show_last_point true
      c.timespan 1200
    end

    p.spline "Rhino & Lama count comparison" do |c|
      c.redraw_interval 5
      c.values_label 'Count'
      c.width 5
      c.show_last_point true
      c.timespan 1200

      c.sensor :rhino_count, color: '#AAAAAA'
      c.sensor :lama_count, color: '#CC1155'
    end

    p.pie "Rhino & Lama count comparison" do |c|
      c.redraw_interval 5
      c.values_label 'Count'
      c.width 5
      c.show_last_point false
      c.timespan 1200

      c.sensor :rhino_count, color: '#AAAAAA'
      c.sensor :lama_count, color: '#CC1155'
    end

  end

  l.page "Ages" do |p|

    p.line "Lama average age", sensor: :lama_average_age do |c|
      c.redraw_interval 5
      c.values_label 'Age'
      c.width 5
      c.show_last_point true
      c.timespan 1200
    end

    p.line "Rhino average age", sensor: :rhino_average_age do |c|
      c.redraw_interval 5
      c.values_label 'Age'
      c.width 5
      c.show_last_point true
      c.timespan 1200
    end

    p.area "Rhino & Lama average age comparison" do |c|
      c.redraw_interval 5
      c.values_label 'Age'
      c.width 5
      c.show_last_point true
      c.timespan 1200

      c.sensor :lama_average_age
      c.sensor :rhino_average_age
    end

    p.pie "Rhino & Lama average age comparison" do |c|
      c.redraw_interval 5
      c.values_label 'Age'
      c.width 5
      c.show_last_point false
      c.timespan 1200

      c.sensor :lama_average_age
      c.sensor :rhino_average_age
    end

    p.highchart_options({
      chart: {
        height: 300
      }
    })
  end

  l.use_utc false
  l.outlier_color '#FF0000'
  l.highchart_options({
    tooltip: {
      value_decimals: 2
    }
  })
end

run layout.to_app
