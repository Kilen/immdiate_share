class ShareInfos::ShareTextController < ApplicationController
  # GET /share_info/share_texts
  # GET /share_info/share_texts.json
  def index
    @share_info_share_texts = ShareInfo::ShareText.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @share_info_share_texts }
    end
  end

  # GET /share_info/share_texts/1
  # GET /share_info/share_texts/1.json
  def show
    @share_info_share_text = ShareInfo::ShareText.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @share_info_share_text }
    end
  end

  # GET /share_info/share_texts/new
  # GET /share_info/share_texts/new.json
  def new
    @share_text = ShareText.new()
  end

  # GET /share_info/share_texts/1/edit
  def edit
    @share_info_share_text = ShareInfo::ShareText.find(params[:id])
  end

  # POST /share_info/share_texts
  # POST /share_info/share_texts.json
  def create
    @share_info_share_text = ShareInfo::ShareText.new(params[:share_info_share_text])

    respond_to do |format|
      if @share_info_share_text.save
        format.html { redirect_to @share_info_share_text, :notice => 'Share text was successfully created.' }
        format.json { render :json => @share_info_share_text, :status => :created, :location => @share_info_share_text }
      else
        format.html { render :action => "new" }
        format.json { render :json => @share_info_share_text.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /share_info/share_texts/1
  # PUT /share_info/share_texts/1.json
  def update
    @share_info_share_text = ShareInfo::ShareText.find(params[:id])

    respond_to do |format|
      if @share_info_share_text.update_attributes(params[:share_info_share_text])
        format.html { redirect_to @share_info_share_text, :notice => 'Share text was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @share_info_share_text.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /share_info/share_texts/1
  # DELETE /share_info/share_texts/1.json
  def destroy
    @share_info_share_text = ShareInfo::ShareText.find(params[:id])
    @share_info_share_text.destroy

    respond_to do |format|
      format.html { redirect_to share_info_share_texts_url }
      format.json { head :no_content }
    end
  end
end
