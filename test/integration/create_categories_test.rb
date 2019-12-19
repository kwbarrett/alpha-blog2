require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  test 'get new category form and create category' do
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: {name: 'sports' } }# validate that posting the category form redirects to the categories/index and results in 1 additional category
      follow_redirect!
    end
    assert_template 'categories/index' # validate that we are redirected to the categories index view
    assert_match 'sports', response.body # validate that the new category is now on the categories index view
  end

  test 'invalid category submission results in failure' do
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: '' } }# validate that posting the category form redirects to the categories/index and results in 1 additional category
    end
    assert_template 'categories/new' # validate that we are redirected to the categories index view
    assert_select 'h2.panel-title' # these last two lines validate that our error message(s) are being displayed as expected
    assert_select 'div.panel-body'
  end
end
