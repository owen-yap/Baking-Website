module ApplicationHelper
  def user_avatar(related_user)
    if related_user.userphoto.attached?
      cl_image_tag related_user.userphoto.key, class: "avatar-large"
    else
      image_tag "default_profile_pic.jpg", alt: "Profile Pic", class: "avatar-large"
    end
  end
end
