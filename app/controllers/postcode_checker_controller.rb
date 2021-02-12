class PostcodeCheckerController < ApplicationController
  before_action :ensure_params_present
  before_action :ensure_postcode

  def check
    checker = Services::PostcodeChecker.new(postcode: postcode_checker_params[:postcode])
    @response = checker.check_postcode
    @notice = if @response[:status] == 'success'
                "We can#{'not' unless @response[:in_area]} service area:  #{postcode_checker_params[:postcode]}"
              else
                @response[:message]
              end
    render :check, notice: @notice
  end

  private

  def postcode_checker_params
    params.require(:postcode_checker).permit(:postcode)
  end

  def ensure_params_present
    return if params[:postcode_checker].present?

    render :check, notice: 'Error: Please ensure you have entered a postcode.'
  end

  def ensure_postcode
    return if params[:postcode_checker][:postcode].present?

    render :check, notice: 'Error: Please ensure you have entered a postcode.'
  end

end
