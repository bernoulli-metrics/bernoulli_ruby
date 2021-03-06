require_relative '../lib/bernoulli'
require 'webmock/rspec'
require 'json'

describe Bernoulli  do
  it 'throws when no client_id is given' do
    has_thrown = false
    begin
      Bernoulli.get_experiments('first', 'user59', nil, nil, true)
    rescue
      has_thrown = true
    end

    has_thrown.should eql(true)
  end

  it 'handles success' do
    ret_val = {
        :status => 'ok',
        :value => [{
            :id => 32
        }]
    }
    stub_request(:get, "https://bernoulli.herokuapp.com/client/api/experiments/?clientId=1&experimentIds=first&segmentData=&shouldBucketIfNecessary=true&userId=user59").to_return(
        :body => ret_val.to_json)

    response = Bernoulli.get_experiments('first', 'user59', 1, nil, true)
    response.length.should eql(1)
    response[0]['id'].should eql(32)
  end

  it 'handles failure' do
    ret_val = {
        :status => 'error',
        :message => 'invalid clientId',
    }

    stub_request(:get, "https://bernoulli.herokuapp.com/client/api/experiments/?clientId=1&experimentIds=first&segmentData=&shouldBucketIfNecessary=true&userId=user59").to_return(
        :body => ret_val.to_json)

    has_thrown = false
    begin
      response = Bernoulli.get_experiments('first', 'user59', 1, nil, true)
    rescue
      has_thrown = true
    end

    has_thrown.should eql(true)
  end

  it 'goal attained makes call' do
    ret_val = {
        :status => 'ok',
        :value => true,
    }

    stub_request(:post, "https://bernoulli.herokuapp.com/client/api/experiments/").to_return(
        :body => ret_val.to_json)

    response = Bernoulli.goal_attained('first', 'user59', 1)

    response.should eql(true)
  end
end
