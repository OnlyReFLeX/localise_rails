require 'logger'

module LocaliseRails
  class << self
    attr_accessor :logger
  end
  self.logger = Logger.new($stdout)
end
