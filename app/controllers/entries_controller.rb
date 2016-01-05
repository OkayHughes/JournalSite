class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /entries
  # GET /entries.json
  def index
    @search = false
    @entries = Entry.all
    @subjects = []
    @entries.each do |entry|
      entry_subjects = entry.subjects.split(",")
      entry_subjects.each do |subject|
        if not (@subjects.include? subject)
            @subjects << subject
        end
      end
    end
    @subjects.sort_by!{ |m| m.downcase }
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @entry = Entry.find(params[:id])
  end

  # GET /entries/new
  def new
    @entry = Entry.new(entry_params)
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def search
    @search = true
    num = params[:number].to_i
    query1 = Entry.search do
      all do
        for i in 0..num 
          if params[("operator"+i.to_s).to_sym] == "and"
            logger.debug params[("text"+i.to_s).to_sym]
            fulltext '"' + params[("text"+i.to_s).to_sym] + '"', :fields => params[("field"+i.to_s).to_sym].to_sym
          end 
        end
      end
    end
    query2 = Entry.search do
      any do
        for i in 0..num 
          if params[("operator"+i.to_s).to_sym] == "or"
            fulltext '"' + params[("text"+i.to_s).to_sym] + '"', :fields => params[("field"+i.to_s).to_sym].to_sym
          end 
        end
      end
    end
    @entries = query1.results #| query2.results
    @subjects = []
    @entries.each do |entry|
      entry_subjects = entry.subjects.split(",")
      entry_subjects.each do |subject|
        if not (@subjects.include? subject)
            @subjects << subject
        end
      end
    end
    @subjects.sort_by!{ |m| m.downcase }
  end

  def subject
    @subject = params[:subject]
    @search = false
    @entries = Entry.all
    @entries = @entries.select{ |x| x.subjects.split(",").include?( @subject ) }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params[:entry]
    end
end
