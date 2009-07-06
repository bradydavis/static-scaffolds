require 'paperclip'
Paperclip::Attachment.interpolations[:custom_root_path] = proc do |attachment, style|
      attachment.instance.paperclip_custom_root_path
    end
