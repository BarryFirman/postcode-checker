class PostcodeCheckerController < ApplicationController
  before_action :ensure_params_present, only: :check
  before_action :ensure_postcode, only: :check
  before_action :shape_postcode, only: :check

  def new; end

  def check
    checker = Services::PostcodeChecker.new(postcode: @postcode)
    @response = checker.check_postcode

    return_statement
  end

  private

  def postcode_checker_params
    params.require(:postcode_checker).permit(:postcode)
  end

  def standard_notice
    @notice = if @response[:status] == 'success'
                if @response[:in_area] == true
                  "Yes! We can service area:  #{@postcode}"
                else
                  "Sorry. We cannot service area: #{@postcode}"
                end
              else
                @response[:message]
              end
  end

  def return_statement
    standard_notice if @notice.nil?

    flash[:notice] = @notice
    redirect_to root_path
  end

  def shape_postcode
    @postcode = UKPostcode.parse(params[:postcode_checker][:postcode]).to_s
  end

  def ensure_params_present
    return if params[:postcode_checker].present?

    @notice = 'System Error: Apologies but something went wrong.'
    return_statement
  end

  def ensure_postcode
    return if params[:postcode_checker][:postcode].present?

    @notice = 'Error: Please ensure you have entered a postcode.'
    return_statement
  end

end
