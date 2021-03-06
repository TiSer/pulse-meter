module PulseMeter
  module Visualize
    class Layout < Base
      include PulseMeter::Mixins::Utils

      def initialize(opts)
        super
        @opts[:pages] ||= []
        @opts[:gchart_options] ||= {}
      end

      def to_app
        PulseMeter::Visualize::App.new(self)
      end

			def page_infos
				res = []
				pages.each_with_index do |p, i|
					res << {
						id: i + 1,
						title: p.title,
            gchart_options: p.gchart_options
					}
				end
				res
			end

			def options
				{
					use_utc: use_utc,
          gchart_options: gchart_options
        }
      end

      def widget(page_id, widget_id, opts = {})
        pages[page_id].widget_data(widget_id, opts)
      end

      def widgets(page_id)
        pages[page_id].widget_datas
      end

      def sensor_list
        PulseMeter::Sensor::Base
          .list_objects
          .select{|s| s.is_a?(PulseMeter::Sensor::Timeline)}
          .map do |s|
          {
            id: s.name,
            annotation: s.annotation || '',
            type: s.class.to_s.split('::').last,
            interval: s.interval
          }
        end
      end

      DEFAULT_TIMESPAN_IN_INTERVALS = 50

      def dynamic_widget(args)
        sensor_names = args.delete(:sensors)
        sensors = sensor_names.map{|n| PulseMeter::Sensor::Base.restore(n)}
        timespan = if args[:timespan] && args[:timespan] > 0
          args[:timespan].to_i
        else
          sensors.first.interval * DEFAULT_TIMESPAN_IN_INTERVALS
        end

        type = args.delete(:type)
        widget_dsl_class = constantize("PulseMeter::Visualize::DSL::Widgets::#{type.capitalize}")
        widget = widget_dsl_class.new('Dynamic Widget')
        widget.timespan(timespan)
        sensor_names.each{|n| widget.sensor(n)}

        widget.to_data.data(args.merge(id: 1, timespan: timespan))
      end

    end
  end
end
