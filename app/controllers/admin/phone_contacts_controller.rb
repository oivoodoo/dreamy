class Admin::PhoneContactsController < Admin::AdminController
  def index
    @contacts = PhoneContact.paginate(:page => params[:page])
  end

  def destroy
    @contact = PhoneContact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(admin_phone_contacts_url) }
      format.xml  { head :ok }
    end
  end
end
