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
    @listing = Listing.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
