class ListingsController < ApplicationController

  helper 'listings'

  def index
    @yui = true
  end

  def get_index
    returnValue = Hash.new
    records = Array.new
    @listings = Listing.all(:order => 'created_at desc')

    @listings.each do |listing|
      tempHash = {}
      id = listing.id
      tempHash["source_amount"] = listing.source_amount
      tempHash["source_type"] = t("listings.types")[listing.source_type.to_i]
      tempHash["rate"] = listing.rate
      tempHash["target_amount"] = listing.target_amount
      tempHash["target_type"] = t("listings.types")[listing.target_type.to_i]
      tempHash["urgency"] = listing.created_at
      tempHash["link"] = listing_url(listing)
      records.push(tempHash)
    end
    returnValue["records"] = records
    returnValue["pageSize"] = 20
    returnValue["recordsReturned"] = @listings.size
    returnValue["totalRecords"] = @listings.size
    returnValue["startIndex"] = 0
    returnValue["sort"] = "urgency"
    returnValue["dir"] = "desc"
    respond_to do |format|
      format.json  { render :json => returnValue.to_json }
    end
  end

  def new
    @listing = Listing.new
    @listing.source_type = 2
    @listing.target_type = 1
    @user = @listing.build_user
  end

  def create
    #I hate accepts_nested_attributes_for!!!!
    @user = User.new(params[:listing][:user])
    params[:listing].delete(:user)
    @user.save

    @listing = Listing.new(params[:listing])
    @listing.user = @user

    if @listing.save
        redirect_to(@listing, :notice => (t('listings.new.created') + " #{view_context.link_to( t('listings.new.link'), (listing_url(@listing) + "/" + @user.password) )}").html_safe )
    else
        render :action => "new"
    end
  end

  def show
    if (Listing.exists?(params[:id]))
      @listing = Listing.find_by_id(params[:id])
    else
      redirect_to(listings_url)
    end
  end

  def edit
      if (Listing.exists?(params[:id]))
        @listing = Listing.find(params[:id])
        if (params[:password]) && (@listing.password_or_master_password?(params[:password]))
          @user = @listing.user
        else
          redirect_to(listings_url)
        end
    end
  end

  def update
    if (Listing.exists?(params[:id]))
        @listing = Listing.find(params[:id])
        if (params[:password]) && (@listing.password_or_master_password?(params[:password]))
          #I hate accepts_nested_attributes_for!!!!
          @user = @listing.user
          @user.update_attributes(params[:listing][:user])
          params[:listing].delete(:user)

          if @listing.update_attributes(params[:listing])
            redirect_to(@listing, :notice => (t('listings.new.created') + " #{view_context.link_to( t('listings.new.link'), (listing_url(@listing) + "/" + @user.password) )}").html_safe )
          else
            render :action => "edit"
          end
        end
    end
  end

  def destroy
    if (Listing.exists?(params[:id]))
      @listing = Listing.find(params[:id])
      if (params[:password]) && (@listing.password_or_master_password?(params[:password]))
        @listing.destroy
      end
    end
    redirect_to(listings_url)
  end

end
