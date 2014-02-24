require 'rest_client'
require 'json'

class Bernoulli
  URL = 'https://bernoulli.herokuapp.com/client/api/experiments/'

  def self.get_experiments(client_id, experiment_ids, user_id, segment_data, should_bucket=true)
    if client_id == nil
      raise ArgumentError, 'client_id'
    end

    if experiment_ids.kind_of?(Array)
      experiment_ids = experiment_ids.join(',')
    end

    response = RestClient.get(URL, {
        :accept => :json,
        :params => {
          :clientId => client_id,
          :experimentIds => experiment_ids,
          :userId => user_id,
          :segmentData => segment_data,
          :shouldBucketIfNecessary => should_bucket,
        }
    })

    data = JSON.parse(response)

    if data['status'] == 'ok'
      return data['value']
    else
      raise data['message']
    end

  end

  def self.goal_attained(client_id, experiment_id, user_id)
    response = RestClient.post(URL, {
        :clientId => client_id,
        :experimentId => experiment_id,
        :userId => user_id,
    })

    data = JSON.parse(response)
    return data['status'] == 'ok'
  end
end
