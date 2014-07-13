require 'spec_helper'

describe UsersController do
  it '#index' do
    expect(get: '/users').to route_to(controller: 'users', action: 'index')
  end

  it '#show' do
    expect(get: '/users/1').to route_to(controller: 'users', action: 'show', id: '1')
  end

  it '#edit' do
    expect(get: '/users/1/edit').to route_to(controller: 'users', action: 'edit', id: '1')
  end

  it '#update' do
    expect(patch: '/users/1/').to route_to(controller: 'users', action: 'update', id: '1')
  end

  it '#adverts' do
    expect(get: '/users/adverts').to route_to(controller: 'users', action: 'adverts')
  end

  it '#account' do
    expect(get: '/account').to route_to(controller: 'users', action: 'account')
  end

end