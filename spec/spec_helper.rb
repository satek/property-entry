require 'aruba/api'
require 'aruba/reporting'
require 'helpers'

src_dir = File.expand_path('../../src', __FILE__)
models_dir = File.expand_path('../../src/models', __FILE__)
$LOAD_PATH.unshift(src_dir) unless $LOAD_PATH.include?(src_dir)
$LOAD_PATH.unshift(models_dir) unless $LOAD_PATH.include?(models_dir)

ENV["WIMDU_ENV"] = 'test'

RSpec.configure do |config|
  config.include Aruba::Api
  config.include Helpers

  config.before(:each) do
    # On startup it might take a little longer for output to
    # arrive. On a really slow machine you might need to increase this
    # value even further.
    @aruba_io_wait_seconds = 1

    restore_env
    clean_current_dir
  end
end
