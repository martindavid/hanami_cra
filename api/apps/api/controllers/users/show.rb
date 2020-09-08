module Api
  module Controllers
    module Users
      class Show
        include Api::Action

        def call(params)
          status 200, Api::Presenters::UserPresenter.new(current_user).to_json
        end
      end
    end
  end
end
