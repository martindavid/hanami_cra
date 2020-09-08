module Api
  module Controllers
    module Health
      class Index
        include Api::Action
        include Api::Controllers::Authentication::Skip

        def call(params)
          status 200, {message: "Success"}.to_json
        end
      end
    end
  end
end
