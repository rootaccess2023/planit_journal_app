class EntriesController < ApplicationController
  before_action :set_entry, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    @selected_date = params[:date]&.to_date
    @selected_date ||= Date.today
    @current_month = @selected_date.strftime("%B")
    @entries = Entry.where("DATE(start_time) = ?", @selected_date)
    @holidays = {
      "New Year’s Day" => "January 1",
      "Chinese New Year" => "February 10",
      "Maundy Thursday" => "March 28",
      "Good Friday" => "March 29",
      "Black Saturday" => "March 30",
      "Day of Valor (Araw ng Kagitingan)" => "April 9",
      "Eid'l Fitr" => "April 10",
      "Labor Day" => "May 1",
      "Independence Day" => "June 12",
      "Ninoy Aquino Day" => "August 21",
      "National Heroes Day" => "August 26",
      "All Saints’ Day" => "November 1",
      "All Souls’ Day" => "November 2",
      "Bonifacio Day" => "November 30",
      "Feast of the Immaculate Conception of Mary" => "December 8",
      "Christmas Eve" => "December 24",
      "Christmas Day" => "December 25",
      "Rizal Day" => "December 30",
      "Last Day of the Year" => "December 31"
    }
    @holidays_in_current_month = @holidays.select { |_, date| Date.parse(date).strftime("%B") == @current_month }
    if @holidays_in_current_month.empty?
      @holidays_in_current_month["Life is too short to wait for holidays to have a good time. Embrace the ordinary moments and make them extraordinary. 🎉" ] = nil
    end
  end

  def show
  end

  def new
    @entry = Entry.new
  end

  def edit
  end

  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to entry_url(@entry), notice: "Entry was successfully created." }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to entry_url(@entry), notice: "Entry was successfully updated." }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entry.destroy!

    respond_to do |format|
      format.html { redirect_to entries_url, notice: "Entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_entry
      @entry = Entry.find(params[:id])
    end

    def entry_params
      params.require(:entry).permit(:category, :title, :description, :start_time, :end_time)
    end
end
