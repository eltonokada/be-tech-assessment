# AceUp Session Scheduler

AceUp Session Scheduler is a web service designed to empower coaches and their clients to schedule coaching sessions seamlessly.

## Database Structure

The service uses a single table, `sessions`, with the following structure:

- `coach_hash_id`: A unique identifier for each coach.
- `client_hash_id`: A unique identifier for each client.
- `start`: The start time of the session.
- `duration`: The duration of the session, in minutes.
- `created_at`: The timestamp when the session was created.
- `updated_at`: The timestamp when the session was last updated.

## Usage

To create a new session, send a POST request to the `/api/v1/sessions` endpoint with the following parameters:

- `coach_hash_id`: The unique identifier of the coach.
- `client_hash_id`: The unique identifier of the client.
- `start`: The start time of the session, in ISO 8601 format.
- `duration`: The duration of the session, in minutes.

Here's an example of how to do this using `curl`:

```bash
curl -X POST \
  http://localhost:3000/api/v1/sessions \
  -H 'Content-Type: application/json' \
  -d '{
    "session": {
      "coach_hash_id": "123",
      "client_hash_id": "456",
      "start": "2022-12-01T14:30:00Z",
      "duration": 60
    }
  }'
```

## Development

This project uses Ruby on Rails. To set up your development environment, follow these steps:

Clone the repository.
Run bundle install to install the dependencies.
Run rails db:migrate to set up the database.
Run rails server to start the development server.

## Testing
This project utilizes RSpec for testing. Execute the tests by running the `rspec` command.

## Challenges
The primary challenge encountered during this project was crafting an accurate query to handle instances of overlapping sessions.

## Potential Improvements
- **Race Condition Management**: Consider the use of Mutex to prevent scenarios where a new session is created during an overlapping time, post-validation.
- **API Authentication/Authorization**: Implementation of JWT (JSON Web Tokens) or simple token authentication could enhance the security of the API.
- **Scalability**: Asynchronous processing could be employed for improved scalability. Additionally, key storage could be managed with Kafka or Redis.