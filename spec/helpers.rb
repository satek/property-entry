module Helpers

  def run_cmd *args
    cmd = args.inject(exe) { |sum, arg|
            sum += " #{arg}"
          }
    puts "Running #{cmd}..."
    run_interactive(cmd)
  end

  def example_params
    {
      title: 'My Title',
      address: 'My Address',
      property_type: 'apartment',
      rate: '12.34',
      max_guests: '5',
      email: 'test@example.com',
      phone_number: '12345678'
    }   
  end

  def input_params process, params
    expect(process.output).to include("Starting with new property")
    expect(process.output).to include("Title: ")
    return unless params.has_key? :title
    type params[:title]
    expect(process.output).to include("Property")
    return unless params.has_key? :property_type
    type params[:property_type]
    expect(process.output).to include("Address: ")
    return unless params.has_key? :address
    type params[:address]
    expect(process.output).to include("Nightly rate in EUR: ")
    return unless params.has_key? :rate
    type params[:rate]
    expect(process.output).to include("Max guests: ")
    return unless params.has_key? :max_guests
    type params[:max_guests]
    expect(process.output).to include("Email: ")
    return unless params.has_key? :email
    type params[:email]
    expect(process.output).to include("Phone number: ")
    return unless params.has_key? :phone_number
    type params[:phone_number]
  end
end
