shared_examples "require admin" do
  it "redirects to the home page" do
    clear_current_user
    set_current_user
    action
    expect(response).to redirect_to root_path
  end

  it "sets a flash message" do
    clear_current_user
    set_current_user
    action
    expect(flash[:danger]).not_to be_nil
  end
end

shared_examples "require user" do
  it "redirects to the home page" do
    clear_current_user
    action
    expect(response).to redirect_to root_path
  end

  it "sets a flash message" do
    clear_current_user
    action
    expect(flash[:danger]).not_to be_nil
  end
end