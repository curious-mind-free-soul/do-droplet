-- sudo -u postgres psql -d myproject
GRANT USAGE ON SCHEMA public TO myprojectuser;
GRANT CREATE ON SCHEMA public TO myprojectuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO myprojectuser;
GRANT ALL ON SCHEMA public TO myprojectuser;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO myprojectuser;
GRANT CREATE ON SCHEMA public TO myprojectuser;
GRANT USAGE ON SCHEMA public TO myprojectuser;