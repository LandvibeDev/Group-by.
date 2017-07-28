module UsermailsHelper
  def body_in_utf8
    require 'charlock_holmes/string'
    body = self.body.decoded
    if body.present?
      encoding = body.detect_encoding[:encoding]
      body = body.force_encoding(encoding).encode('UTF-8')
    end
    return body
  end
end
