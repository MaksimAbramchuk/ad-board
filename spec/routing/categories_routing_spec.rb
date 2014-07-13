require 'spec_helper'

describe CategoriesController do
  it '#index' do
    expect(get: '/categories').to route_to(controller: 'categories', action: 'index')
  end

  it '#new' do
    expect(get: '/categories/new').to route_to(controller: 'categories', action: 'new')
  end

  it '#create' do
    expect(post: '/categories/').to route_to(controller: 'categories', action: 'create')
  end

  it '#edit' do
    expect(get: '/categories/1/edit').to route_to(controller: 'categories', action: 'edit', id: '1')
  end

  it '#update' do
    expect(patch: '/categories/1/').to route_to(controller: 'categories', action: 'update', id: '1')
  end

  it '#destroy' do
    expect(delete: '/categories/1/').to route_to(controller: 'categories', action: 'destroy', id: '1')
  end

end