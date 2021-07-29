class HomesController < ApplicationController
  # トップページ
  def top
    @user = User.new
  end

  # サイト説明ページ
  # def about; end
end
