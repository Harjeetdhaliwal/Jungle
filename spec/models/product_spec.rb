require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it 'should save a product if all the validations are true' do
      @category = Category.new(name: "Furniture")
      @product = Product.new(name: "Sofa", price_cents: 50000, quantity: 5, category: @category)
      @product.save
      expect(@product.errors).not_to include(/can't be blank/)
    end

    it 'should not save a product if name is missing' do
      @category = Category.new(name: "Furniture")
      @product = Product.new(price_cents: 5000, quantity: 5, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include(/can't be blank/)
    end

    it 'should not save a product is price is missing' do
      @category = Category.new(name: "Furniture")
      @product = Product.new(name: "Sofa", quantity: 5, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include(/can't be blank/)
    end

    it 'should not save a product is quantity is missing' do
      @category = Category.new(name: "Furniture")
      @product = Product.new(name: "Sofa", price_cents: 50000, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include(/can't be blank/)
    end

    it 'should not save a product is category is missing' do
      @product = Product.new(name: "Sofa",price_cents: 5000, quantity: 5)
      @product.save
      expect(@product.errors.full_messages).to include(/can't be blank/)
    end
  end
end
