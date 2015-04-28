class VerificationsController < ApplicationController

	skip_before_filter :verify_authenticity_token
    def generate_code
        phone_number = params["phone_number"]
        code = Random.rand(10000..99999).to_s
        Verification.create(phone_number: phone_number, code: code)
        SinchSms.send('53c3f2a5-23e6-400c-8b56-442b67e7f442', '4i7JtsBJsEqex9B6W49+YA==', "Tu codigo de verificacion es #{code}", phone_number)
        render status: 200, nothing: true
    end
    def verify_code
        phone_number = params["phone_number"]
        code = params["code"]
        verification = Verification.where(phone_number: phone_number, code: code).first
        if verification
           verification.destroy
            render status: 200, json: {verified: true}.to_json
        else
            render status: 200, json: {verified: false}.to_json
        end
    end
end
