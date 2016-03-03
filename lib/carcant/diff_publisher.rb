module Carcant
  class DiffPublisher

    def self.subscribers
      @subscribers ||= []
    end

    def self.publish(diff: )
      subscribers.each do |subscriber|
        publish_hires(subscriber, diff['+'])
        publish_layoffs(subscriber, diff['-'])
      end
    end

    def self.publish_hires(subscriber, hires)
      hires.each { |hire| subscriber.hired("#{hire.name} has been hired!") }
    end
    private_class_method :publish_hires

    def self.publish_layoffs(subscriber, layoffs)
      layoffs.each { |layoff| subscriber.fired("#{layoff.name} has been fired :(") }
    end
    private_class_method :publish_layoffs
  end
end
