require 'spec_helper'

describe AdvertsController do
  it '#index' do
    expect(get: '/').to route_to(controller: 'adverts', action: 'index')
  end

  it '#new' do
    expect(get: '/adverts/new').to route_to(controller: 'adverts', action: 'new')
  end

  it '#create' do
    expect(post: '/adverts').to route_to(controller: 'adverts', action: 'create')
  end

  it '#edit' do
    expect(get: '/adverts/1/edit').to route_to(controller: 'adverts', action: 'edit', id: '1')
  end

  it '#update' do
    expect(patch: '/adverts/1/').to route_to(controller: 'adverts', action: 'update', id: '1')
  end

  it '#awaiting_publication' do
    expect(get: '/adverts/awaiting_publication').to route_to(controller: 'adverts', action: 'awaiting_publication')
  end

  it '#change' do
    expect(get: '/adverts/1/change').to route_to(controller: 'adverts', action: 'change', id: '1')
  end

  it '#change_state' do
    expect(put: '/adverts/1/change_state').to route_to(controller: 'adverts', action: 'change_state', id: '1')
  end

  it '#logs' do
    expect(get: '/adverts/1/logs').to route_to(controller: 'adverts', action: 'logs', id: '1')
  end
end