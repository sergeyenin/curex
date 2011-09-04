class ListingsController < ApplicationController

  helper 'listings'

  def index
  end

  def new
    @listing = Listing.new
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
  end

  def update
  end

  def destroy
    if (Listing.exists?(params[:id]))
      @listing = Listing.find(params[:id])
      if (params[:password]) && (@listing.user.password == params[:password])
        @listing.destroy
      end
    end
    redirect_to(listings_url)
  end

end
