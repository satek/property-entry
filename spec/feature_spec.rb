require "spec_helper"
require "db_setup"
require "property"

describe "Wimdu CLI" do
  let(:exe) { File.expand_path('../../bin/wimdu', __FILE__) }

  before(:each) do
    Property.delete_all
  end

  describe "new" do
    it "allows for entering data" do
      process = run_cmd("new")
      input_params process, example_params
    end
  end

  describe "continue" do
    it "allows for continuing data entry" do
      process = run_cmd("new")
      input_params process, example_params.tap { |params| params[:email] = '' }
      expect(process.output).to include("Property is not complete.")

      property_id = Property.last.id

      continue_process = run_cmd("continue", property_id)
      expect(continue_process.output).to include("Continuing with #{property_id}")
      expect(continue_process.output).to include("Email")
      type "test@example.com"
      expect(continue_process.output).to include("Finished input.")
      expect(continue_process.output).to include("Property is complete.")
    end
  end
end
