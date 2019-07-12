class Api::V1::StoresController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_device, only: %i(registration unregistration)
  before_action :find_store, only: :numbers
  def index
    @regions = Region.all.includes(prefectures: {areas: :stores})
    render json: @regions
  end
  def registration
    if device.is_password? params[:password]
      update_device
    else
      render json: {message: "失敗レスポンス"}, status: 401
    end
  end
  def unregistration
    if device.update registered: false
      render json: {message: "Success!"}, status: 200
    else
      render json: {errors: device.errors.full_messages}, status: 422
    end
  end
  def numbers
		@devices = store.devices.where(registered: false)
    if devices.blank?
      render json: {message: "不正なエラー"}, status: 500
    end
  end
  private
  attr_reader :devices, :device, :regions, :store, :devices
  def update_device
    if device.update registered: true
      render json: {message: "Success!"}, status: 200
    else
      render json: {errors: device.errors.full_messages}, status: 422
    end
  end
  def find_device
    @device = Device.find_by number: params[:number],
      store_id: params[:store_id]
    render json: {message: "店舗が見つかりません"}, status: 404 unless device
  end
  def find_store
    @store = Store.find_by id: params[:id]
    render json: {message: "店舗が見つかりません"}, status: 404 unless store
  end
end
