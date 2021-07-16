class FaqsController < ApplicationController
  before_action :set_faq, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ new create edit update destroy ]
  # GET /faqs or /faqs.json
  def index
    @faqs = Faq.where(nil) # creates an anonymous scope
    set_faq_categories
    @faqs = @faqs.filter_by_search(params[:search]) if (params[:search].present?)
    @faqs = @faqs.filter_by_category(params[:category]) if (params[:category].present? && params[:category] != "All")
  end

  # GET /faqs/1 or /faqs/1.json
  def show
  end

  # GET /faqs/new
  def new
    @faq = Faq.new
  end

  # GET /faqs/1/edit
  def edit
  end

  # POST /faqs or /faqs.json
  def create
    @faq = Faq.new(faq_params)

    respond_to do |format|
      if @faq.save
        format.html { redirect_to @faq, notice: "Faq was successfully created." }
        format.json { render :show, status: :created, location: @faq }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /faqs/1 or /faqs/1.json
  def update
    respond_to do |format|
      if @faq.update(faq_params)
        format.html { redirect_to @faq, notice: "Faq was successfully updated." }
        format.json { render :show, status: :ok, location: @faq }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /faqs/1 or /faqs/1.json
  def destroy
    @faq.destroy
    respond_to do |format|
      format.html { redirect_to faqs_url, notice: "Faq was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_faq
      @faq = Faq.friendly.find(params[:id])
    end

    def set_faq_categories
      @faq_categories = []
      @faqs.each do |faq|
        @faq_categories << faq.category
      end
      @faq_categories = @faq_categories.uniq
    end

    # Only allow a list of trusted parameters through.
    def faq_params
      params.require(:faq).permit(:en_question, :en_answer, :zh_tw_question, :zh_tw_answer, :zh_cn_question, :zh_cn_answer, :hmn_question, :hmn_answer, :vi_question, :vi_answer, :category, :search)
    end
end
