class OffersController < ApplicationController
  # before_action :set_offer, only: %i[ show edit update destroy ]
before_action :authenticate_member!
  # GET /offers or /offers.json
  def index
    @offers = Offer.all
  end

  # GET /offers/1 or /offers/1.json
  def show
  end

  # GET /offers/new
  def new
  html = render_to_string(partial: 'form', locals: { offer: Offer.new })
  render operations: cable_car
    .inner_html('#slideover-content', html: html)
    .text_content('#slideover-header', text: 'Post a new offer')
end

  # GET /offers/1/edit
  def edit
    html = render_to_string(partial: 'form', locals: { offer: @offer })
  render operations: cable_car
    .inner_html('#slideover-content', html: html)
    .text_content('#slideover-header', text: 'Update offer')
  end

  # POST /offers or /offers.json
  
  def create
    @offer = Offer.new(offer_params)
    @offer.profile = current_member.profile

    # respond_to do |format|
      if @offer.save
    html = render_to_string(partial: 'offer', locals: { offer: @offer })
    render operations: cable_car
      .prepend('#offers', html: html)
      .dispatch_event(name: 'submit:success')
  else
    html = render_to_string(partial: 'form', locals: { offer: @offer })
    render operations: cable_car
      .inner_html('#offer-form', html: html), status: :unprocessable_entity
      end
    # end
  end

  # PATCH/PUT /offers/1 or /offers/1.json
  def update
      if @offer.update(offer_params)
    html = render_to_string(partial: 'offer', locals: { offer: @offer })
    render operations: cable_car
      .replace(dom_id(@job), html: html)
      .dispatch_event(name: 'submit:success')
  else
    html = render_to_string(partial: 'form', locals: { job: @job })
    render operations: cable_car
      .inner_html('#job-form', html: html), status: :unprocessable_entity
  end
    end
  end

  # DELETE /offers/1 or /offers/1.json
  def destroy
    @offer.destroy

    respond_to do |format|
      format.html { redirect_to offers_url, notice: "Offer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def offer_params
      params.require(:offer).permit(:title, :status, :offer_type, :location, :profile_id, :description)
    end
end
