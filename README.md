# AceUp Session Scheduler

AceUp Session Scheduler is a web service designed to empower coaches and their clients to schedule coaching sessions seamlessly.

## Database Structure

The service uses three tables: `sessions`, `coaches`, and `clients`.

The `sessions` table has the following structure:

- `coach_hash_id`: A foreign key referencing the unique identifier of the coach.
- `client_hash_id`: A foreign key referencing the unique identifier of the client.
- `start`: The start time of the session.
- `duration`: The duration of the session, in minutes.
- `created_at`: The timestamp when the session was created.
- `updated_at`: The timestamp when the session was last updated.

The `coaches` table has the following structure:

- `coach_hash_id`: A unique identifier for each coach.
- `created_at`: The timestamp when the coach was created.
- `updated_at`: The timestamp when the coach was last updated.

The `clients` table has the following structure:

- `client_hash_id`: A unique identifier for each client.
- `created_at`: The timestamp when the client was created.
- `updated_at`: The timestamp when the client was last updated.

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
We have Client and Coach models, so to proper testing, we need to have valid coaches and clients in database, so for testing purposes, please run first the `db:seed` task.
The `db:seed` task is used to populate the database with initial data for `Client` and `Coach` models. 
This task generates records with unique `client_hash_id` and `coach_hash_id` values, which are used as foreign keys in the `Session` model.

To run the `db:seed` task, use the following command in your terminal:

```bash
rails db:seed
```

## Testing
This project utilizes RSpec for testing. Execute the tests by running the `rspec` command.

## Challenges
The main challenge in this project was developing a precise query to manage overlapping sessions. To address this, I implemented a custom validator, `OverlappingSessionsValidator`, which contains a query specifically designed to handle such scenarios. You can find this validator in `app/validators/overlapping_sessions_validator.rb`.

## Potential Improvements
- **Race Condition Management**: Consider the use of Mutex to prevent scenarios where a new session is created during an overlapping time, post-validation.
- **API Authentication/Authorization**: Implementation of JWT (JSON Web Tokens) or simple token authentication could enhance the security of the API.
- **Scalability**: Asynchronous processing could be employed for improved scalability. Additionally, key storage could be managed with Kafka or Redis.