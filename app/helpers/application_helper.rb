module ApplicationHelper
  def user_avatar(related_user, class_declarations)
    if related_user.userphoto.attached?
      cl_image_tag related_user.userphoto.key, class: class_declarations
    else
      image_tag "default_profile_pic.jpg", alt: "Profile Pic", class: class_declarations
    end
  end
end
