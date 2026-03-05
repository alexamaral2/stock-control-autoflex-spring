--
-- PostgreSQL database dump
--

-- Dumped from database version 18.3 (Debian 18.3-1.pgdg13+1)
-- Dumped by pg_dump version 18.3 (Debian 18.3-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak_user;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak_user;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak_user;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak_user;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.authenticator_config (
    id character varying(36) CONSTRAINT authenticator_id_not_null NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak_user;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) CONSTRAINT authenticator_config_authenticator_id_not_null NOT NULL,
    value text,
    name character varying(255) CONSTRAINT authenticator_config_name_not_null NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak_user;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak_user;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak_user;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO keycloak_user;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak_user;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak_user;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) CONSTRAINT app_node_registrations_application_id_not_null NOT NULL,
    value integer,
    name character varying(255) CONSTRAINT app_node_registrations_name_not_null NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak_user;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.client_scope (
    id character varying(36) CONSTRAINT client_template_id_not_null NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak_user;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) CONSTRAINT client_template_attributes_template_id_not_null NOT NULL,
    value character varying(2048),
    name character varying(255) CONSTRAINT client_template_attributes_name_not_null NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak_user;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak_user;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) CONSTRAINT template_scope_mapping_template_id_not_null NOT NULL,
    role_id character varying(36) CONSTRAINT template_scope_mapping_role_id_not_null NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak_user;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak_user;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO keycloak_user;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak_user;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer,
    version integer DEFAULT 0
);


ALTER TABLE public.credential OWNER TO keycloak_user;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak_user;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak_user;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak_user;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO keycloak_user;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak_user;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak_user;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak_user;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak_user;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak_user;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak_user;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak_user;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak_user;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak_user;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak_user;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak_user;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean,
    authenticate_by_default boolean,
    realm_id character varying(36),
    add_token_role boolean,
    trust_email boolean,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean,
    organization_id character varying(255),
    hide_on_login boolean
);


ALTER TABLE public.identity_provider OWNER TO keycloak_user;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak_user;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak_user;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak_user;

--
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO keycloak_user;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL,
    description character varying(255)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak_user;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false CONSTRAINT keycloak_role_application_role_not_null NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak_user;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak_user;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO keycloak_user;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0,
    remember_me boolean
);


ALTER TABLE public.offline_user_session OWNER TO keycloak_user;

--
-- Name: org; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO keycloak_user;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO keycloak_user;

--
-- Name: org_invitation; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.org_invitation (
    id character varying(36) NOT NULL,
    organization_id character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    created_at integer NOT NULL,
    expires_at integer,
    invite_link character varying(2048)
);


ALTER TABLE public.org_invitation OWNER TO keycloak_user;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak_user;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak_user;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak_user;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak_user;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak_user;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak_user;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak_user;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak_user;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak_user;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak_user;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak_user;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak_user;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak_user;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak_user;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak_user;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak_user;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak_user;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak_user;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.resource_server (
    id character varying(36) CONSTRAINT resource_server_client_id_not_null NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak_user;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak_user;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) CONSTRAINT resource_server_policy_resource_server_client_id_not_null NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak_user;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) CONSTRAINT resource_server_resource_resource_server_client_id_not_null NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak_user;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) CONSTRAINT resource_server_scope_resource_server_client_id_not_null NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak_user;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak_user;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO keycloak_user;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak_user;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak_user;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak_user;

--
-- Name: server_config; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.server_config (
    server_config_key character varying(255) NOT NULL,
    value text NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.server_config OWNER TO keycloak_user;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO keycloak_user;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak_user;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak_user;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak_user;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak_user;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak_user;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) CONSTRAINT user_federation_mapper_confi_user_federation_mapper_id_not_null NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak_user;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak_user;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak_user;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak_user;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak_user;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak_user;

--
-- Name: workflow_state; Type: TABLE; Schema: public; Owner: keycloak_user
--

CREATE TABLE public.workflow_state (
    execution_id character varying(255) NOT NULL,
    resource_id character varying(255) NOT NULL,
    workflow_id character varying(255) NOT NULL,
    resource_type character varying(255),
    scheduled_step_id character varying(255),
    scheduled_step_timestamp bigint
);


ALTER TABLE public.workflow_state OWNER TO keycloak_user;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
2aec1f7f-615c-4062-91d6-37a12d04f9c3	\N	auth-cookie	451d845a-b81f-4125-b1b3-f3ec34d3cedb	f986a234-9c3d-4051-b136-67da440c527b	2	10	f	\N	\N
a2c21d55-d670-40fe-8bf5-7631bc88f322	\N	auth-spnego	451d845a-b81f-4125-b1b3-f3ec34d3cedb	f986a234-9c3d-4051-b136-67da440c527b	3	20	f	\N	\N
a923b64a-d1be-404c-9f28-595fedd80da5	\N	identity-provider-redirector	451d845a-b81f-4125-b1b3-f3ec34d3cedb	f986a234-9c3d-4051-b136-67da440c527b	2	25	f	\N	\N
d55caa8b-0412-4833-90d6-c74176ee7f0a	\N	\N	451d845a-b81f-4125-b1b3-f3ec34d3cedb	f986a234-9c3d-4051-b136-67da440c527b	2	30	t	77411224-e7f5-4149-86f7-be4bc5240e38	\N
b7e936ef-326d-4a9f-a533-490306758826	\N	auth-username-password-form	451d845a-b81f-4125-b1b3-f3ec34d3cedb	77411224-e7f5-4149-86f7-be4bc5240e38	0	10	f	\N	\N
9fb99314-5ebe-46fd-b59c-7c93a272c2b7	\N	\N	451d845a-b81f-4125-b1b3-f3ec34d3cedb	77411224-e7f5-4149-86f7-be4bc5240e38	1	20	t	54c857c0-6293-46fc-b5e4-dc1934505e85	\N
da103aa2-c061-4ccf-967a-236795e39636	\N	conditional-user-configured	451d845a-b81f-4125-b1b3-f3ec34d3cedb	54c857c0-6293-46fc-b5e4-dc1934505e85	0	10	f	\N	\N
fed02b89-42cb-4d9a-8bb7-d9bb2398af17	\N	conditional-credential	451d845a-b81f-4125-b1b3-f3ec34d3cedb	54c857c0-6293-46fc-b5e4-dc1934505e85	0	20	f	\N	0d7ba54f-0fb6-4a68-bb1f-71358a358a74
ebc74581-dfe8-4ad6-bfdb-b7dcbde9223b	\N	auth-otp-form	451d845a-b81f-4125-b1b3-f3ec34d3cedb	54c857c0-6293-46fc-b5e4-dc1934505e85	2	30	f	\N	\N
fdf9dc52-8616-4f41-a0df-4385b00aa433	\N	webauthn-authenticator	451d845a-b81f-4125-b1b3-f3ec34d3cedb	54c857c0-6293-46fc-b5e4-dc1934505e85	3	40	f	\N	\N
44634ea2-287d-4d71-a1ff-6d919302ae25	\N	auth-recovery-authn-code-form	451d845a-b81f-4125-b1b3-f3ec34d3cedb	54c857c0-6293-46fc-b5e4-dc1934505e85	3	50	f	\N	\N
d9c41444-2fd4-4fa9-b244-d1c66ab2cf98	\N	direct-grant-validate-username	451d845a-b81f-4125-b1b3-f3ec34d3cedb	79d4859f-0f2c-4543-98c1-77549dc02f1d	0	10	f	\N	\N
cbdac53a-28b9-4dad-b069-ac7670cda7f9	\N	direct-grant-validate-password	451d845a-b81f-4125-b1b3-f3ec34d3cedb	79d4859f-0f2c-4543-98c1-77549dc02f1d	0	20	f	\N	\N
a5da7c0b-5705-4853-90ce-918a9c3a2861	\N	\N	451d845a-b81f-4125-b1b3-f3ec34d3cedb	79d4859f-0f2c-4543-98c1-77549dc02f1d	1	30	t	fbc1e727-9fc1-4eb9-9168-05f2b975a11d	\N
a58ffe40-e1ea-45a5-ac87-ba04e07c9d17	\N	conditional-user-configured	451d845a-b81f-4125-b1b3-f3ec34d3cedb	fbc1e727-9fc1-4eb9-9168-05f2b975a11d	0	10	f	\N	\N
81be64d2-54a7-4aac-879b-e6c5fd2114f3	\N	direct-grant-validate-otp	451d845a-b81f-4125-b1b3-f3ec34d3cedb	fbc1e727-9fc1-4eb9-9168-05f2b975a11d	0	20	f	\N	\N
049cc587-bf9a-45af-a186-fdc3c50f708d	\N	registration-page-form	451d845a-b81f-4125-b1b3-f3ec34d3cedb	a461e5c1-7ad1-4810-8a5a-905a8d19be0b	0	10	t	b5c28d77-fcbb-4b10-9369-3224ee417166	\N
d5a9baf4-3ec9-46b0-9ba9-ad3ec87e6b9a	\N	registration-user-creation	451d845a-b81f-4125-b1b3-f3ec34d3cedb	b5c28d77-fcbb-4b10-9369-3224ee417166	0	20	f	\N	\N
6cc866ec-9762-44e1-855c-4e2d684e6084	\N	registration-password-action	451d845a-b81f-4125-b1b3-f3ec34d3cedb	b5c28d77-fcbb-4b10-9369-3224ee417166	0	50	f	\N	\N
b60cda53-a4d9-4b7b-afaa-7b9f19b9f2e8	\N	registration-recaptcha-action	451d845a-b81f-4125-b1b3-f3ec34d3cedb	b5c28d77-fcbb-4b10-9369-3224ee417166	3	60	f	\N	\N
b6428d22-e2e9-4b24-8876-ee829c8442f7	\N	registration-terms-and-conditions	451d845a-b81f-4125-b1b3-f3ec34d3cedb	b5c28d77-fcbb-4b10-9369-3224ee417166	3	70	f	\N	\N
b8ce614f-0daa-4acf-b02f-0c334311a055	\N	reset-credentials-choose-user	451d845a-b81f-4125-b1b3-f3ec34d3cedb	f192c125-2769-4a0c-94cf-dff08fd451a6	0	10	f	\N	\N
1a9534eb-18d3-4f62-9b62-6f586662f930	\N	reset-credential-email	451d845a-b81f-4125-b1b3-f3ec34d3cedb	f192c125-2769-4a0c-94cf-dff08fd451a6	0	20	f	\N	\N
716a97bb-0243-46ae-97aa-3a56c33a4111	\N	reset-password	451d845a-b81f-4125-b1b3-f3ec34d3cedb	f192c125-2769-4a0c-94cf-dff08fd451a6	0	30	f	\N	\N
50aad355-9e53-437b-9141-b6c6aad49976	\N	\N	451d845a-b81f-4125-b1b3-f3ec34d3cedb	f192c125-2769-4a0c-94cf-dff08fd451a6	1	40	t	6e2ac8cb-0c7e-4cf4-b174-0b1d1b23ebeb	\N
379c8c90-ab23-47b8-9dc0-4df46355e002	\N	conditional-user-configured	451d845a-b81f-4125-b1b3-f3ec34d3cedb	6e2ac8cb-0c7e-4cf4-b174-0b1d1b23ebeb	0	10	f	\N	\N
0e7512c8-32e1-4773-9d9f-dcaf865f6c2b	\N	reset-otp	451d845a-b81f-4125-b1b3-f3ec34d3cedb	6e2ac8cb-0c7e-4cf4-b174-0b1d1b23ebeb	0	20	f	\N	\N
a9d20404-51c4-4e54-803f-c278c1ce67d4	\N	client-secret	451d845a-b81f-4125-b1b3-f3ec34d3cedb	7fde9135-8033-4736-a43f-a78c024b2125	2	10	f	\N	\N
7fc9fb64-c7a2-480b-aca9-717bb32e60d5	\N	client-jwt	451d845a-b81f-4125-b1b3-f3ec34d3cedb	7fde9135-8033-4736-a43f-a78c024b2125	2	20	f	\N	\N
243e5c9d-1448-48ce-b307-031029670ca2	\N	client-secret-jwt	451d845a-b81f-4125-b1b3-f3ec34d3cedb	7fde9135-8033-4736-a43f-a78c024b2125	2	30	f	\N	\N
1c8582f1-633c-4c94-ad4d-77875c5a9ed4	\N	client-x509	451d845a-b81f-4125-b1b3-f3ec34d3cedb	7fde9135-8033-4736-a43f-a78c024b2125	2	40	f	\N	\N
4c46a97f-f245-4209-8e0f-fb1926579a9c	\N	idp-review-profile	451d845a-b81f-4125-b1b3-f3ec34d3cedb	e694f4d3-d830-4546-8f9e-181e03e54c95	0	10	f	\N	2ed50cdc-9757-4c73-89b5-5164f30861f0
26c4933c-f0ef-4323-8832-262f8efcde39	\N	\N	451d845a-b81f-4125-b1b3-f3ec34d3cedb	e694f4d3-d830-4546-8f9e-181e03e54c95	0	20	t	17e63ad6-96f8-4b57-8c8b-798281704600	\N
78475b85-fe34-4122-a681-114587d1c090	\N	idp-create-user-if-unique	451d845a-b81f-4125-b1b3-f3ec34d3cedb	17e63ad6-96f8-4b57-8c8b-798281704600	2	10	f	\N	41785f9c-4e54-48ab-bf4e-0930e738c16e
dec9cadf-44bb-4713-8204-7ba5a9b12a68	\N	\N	451d845a-b81f-4125-b1b3-f3ec34d3cedb	17e63ad6-96f8-4b57-8c8b-798281704600	2	20	t	2e04c706-cf78-4911-b7e3-4b1087dd6bc3	\N
cf7ff251-48f8-4f19-b8f6-2175dc154f00	\N	idp-confirm-link	451d845a-b81f-4125-b1b3-f3ec34d3cedb	2e04c706-cf78-4911-b7e3-4b1087dd6bc3	0	10	f	\N	\N
23ddd27b-266b-4cc0-a305-003266a852eb	\N	\N	451d845a-b81f-4125-b1b3-f3ec34d3cedb	2e04c706-cf78-4911-b7e3-4b1087dd6bc3	0	20	t	d05a9e7c-cd7d-4ba6-9aab-1f0ca6429196	\N
8f956bea-3ea6-4b1a-a812-2fff1201154c	\N	idp-email-verification	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d05a9e7c-cd7d-4ba6-9aab-1f0ca6429196	2	10	f	\N	\N
bea3d607-2b77-4e69-b977-8320e0880308	\N	\N	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d05a9e7c-cd7d-4ba6-9aab-1f0ca6429196	2	20	t	420792a6-4a0b-437b-98f1-d1c7d54f9bb9	\N
2b40e033-686e-4cbd-80c9-a4e98758326f	\N	idp-username-password-form	451d845a-b81f-4125-b1b3-f3ec34d3cedb	420792a6-4a0b-437b-98f1-d1c7d54f9bb9	0	10	f	\N	\N
bafd72c4-83ed-4ef4-9c66-0b377368bf0e	\N	\N	451d845a-b81f-4125-b1b3-f3ec34d3cedb	420792a6-4a0b-437b-98f1-d1c7d54f9bb9	1	20	t	1dbe0b50-efdf-420f-b8da-5b7acef6d753	\N
a98d7b40-87b2-4eba-aedb-d5278c8b9cff	\N	conditional-user-configured	451d845a-b81f-4125-b1b3-f3ec34d3cedb	1dbe0b50-efdf-420f-b8da-5b7acef6d753	0	10	f	\N	\N
6f2b298a-bb44-4c67-a214-e31e361f4820	\N	conditional-credential	451d845a-b81f-4125-b1b3-f3ec34d3cedb	1dbe0b50-efdf-420f-b8da-5b7acef6d753	0	20	f	\N	0cb9c4cf-82b2-45f0-a8fb-efd9d71174fc
7ba6c5f8-21f3-4436-9117-f02bc33f808f	\N	auth-otp-form	451d845a-b81f-4125-b1b3-f3ec34d3cedb	1dbe0b50-efdf-420f-b8da-5b7acef6d753	2	30	f	\N	\N
a26fa7a9-a732-40d8-bbdc-ac9a07ff9cd5	\N	webauthn-authenticator	451d845a-b81f-4125-b1b3-f3ec34d3cedb	1dbe0b50-efdf-420f-b8da-5b7acef6d753	3	40	f	\N	\N
25c1f8a9-ac33-4b5b-8229-57b41e7c2372	\N	auth-recovery-authn-code-form	451d845a-b81f-4125-b1b3-f3ec34d3cedb	1dbe0b50-efdf-420f-b8da-5b7acef6d753	3	50	f	\N	\N
01f52242-135f-46bc-b3b7-2d513285cf5f	\N	http-basic-authenticator	451d845a-b81f-4125-b1b3-f3ec34d3cedb	b3ed8e65-acb1-4f26-915e-6566efea6d0a	0	10	f	\N	\N
36dfdaa2-ee2e-4ea5-8271-71ca3f654b3c	\N	docker-http-basic-authenticator	451d845a-b81f-4125-b1b3-f3ec34d3cedb	4ccec81c-90d7-4967-bb8f-59cdef8c890a	0	10	f	\N	\N
1e267d29-5a85-46bb-9680-21a4497c79b1	\N	auth-cookie	41afada5-8096-4d14-92f4-5079d0a42a1d	bfb14e97-5a56-496a-adfd-ea5224e9c95e	2	10	f	\N	\N
45ec2878-3982-4c0c-823d-1fb24070364e	\N	auth-spnego	41afada5-8096-4d14-92f4-5079d0a42a1d	bfb14e97-5a56-496a-adfd-ea5224e9c95e	3	20	f	\N	\N
e0aa5413-4de1-4a0c-ab8c-0ec08d6c7fc8	\N	identity-provider-redirector	41afada5-8096-4d14-92f4-5079d0a42a1d	bfb14e97-5a56-496a-adfd-ea5224e9c95e	2	25	f	\N	\N
5073f959-bf60-4d13-8c18-6cf44bfb8ed2	\N	\N	41afada5-8096-4d14-92f4-5079d0a42a1d	bfb14e97-5a56-496a-adfd-ea5224e9c95e	2	30	t	82ac394f-8773-4023-8359-d970f41494a5	\N
522b4eb1-14e5-4765-9122-569be746c218	\N	auth-username-password-form	41afada5-8096-4d14-92f4-5079d0a42a1d	82ac394f-8773-4023-8359-d970f41494a5	0	10	f	\N	\N
36994a89-4db7-491c-8c23-fcd30e4143df	\N	\N	41afada5-8096-4d14-92f4-5079d0a42a1d	82ac394f-8773-4023-8359-d970f41494a5	1	20	t	d82f3d3d-d66f-48fb-9d1b-03bf339bac03	\N
a3013a04-2ed5-4396-9bbf-3a95c151ec65	\N	conditional-user-configured	41afada5-8096-4d14-92f4-5079d0a42a1d	d82f3d3d-d66f-48fb-9d1b-03bf339bac03	0	10	f	\N	\N
87264614-1146-4123-acb0-cb5a784259bc	\N	conditional-credential	41afada5-8096-4d14-92f4-5079d0a42a1d	d82f3d3d-d66f-48fb-9d1b-03bf339bac03	0	20	f	\N	63a5bd44-efb3-4bf8-895c-278c3df1887d
92e82cb9-7323-44f6-a7c6-c177c7c15f88	\N	auth-otp-form	41afada5-8096-4d14-92f4-5079d0a42a1d	d82f3d3d-d66f-48fb-9d1b-03bf339bac03	2	30	f	\N	\N
401da302-7adc-4840-a346-1f36d17e446d	\N	webauthn-authenticator	41afada5-8096-4d14-92f4-5079d0a42a1d	d82f3d3d-d66f-48fb-9d1b-03bf339bac03	3	40	f	\N	\N
9f8e3ab6-45cb-4cb4-b6ce-ff29b6085185	\N	auth-recovery-authn-code-form	41afada5-8096-4d14-92f4-5079d0a42a1d	d82f3d3d-d66f-48fb-9d1b-03bf339bac03	3	50	f	\N	\N
184006bf-0d21-4ed6-a2c6-08762b545f01	\N	\N	41afada5-8096-4d14-92f4-5079d0a42a1d	bfb14e97-5a56-496a-adfd-ea5224e9c95e	2	26	t	66511c0d-1961-47c9-9f8f-1174cdddaa75	\N
cc54052e-c396-4c22-8cf7-6c3cfea7f980	\N	\N	41afada5-8096-4d14-92f4-5079d0a42a1d	66511c0d-1961-47c9-9f8f-1174cdddaa75	1	10	t	261bdafd-3fcd-4551-afe0-99de0cac72f0	\N
69060879-d5fa-4532-99a0-aadfcdbe8121	\N	conditional-user-configured	41afada5-8096-4d14-92f4-5079d0a42a1d	261bdafd-3fcd-4551-afe0-99de0cac72f0	0	10	f	\N	\N
33df6e16-e6b0-4d74-bd38-60ea0e00a97c	\N	organization	41afada5-8096-4d14-92f4-5079d0a42a1d	261bdafd-3fcd-4551-afe0-99de0cac72f0	2	20	f	\N	\N
f307cd84-8d6e-4c62-bd9a-cf8c2b49440f	\N	direct-grant-validate-username	41afada5-8096-4d14-92f4-5079d0a42a1d	4d6c9170-5adb-40d8-98ac-2a604e8fe5e8	0	10	f	\N	\N
d751fb72-9309-45b3-b11d-2581332e644d	\N	direct-grant-validate-password	41afada5-8096-4d14-92f4-5079d0a42a1d	4d6c9170-5adb-40d8-98ac-2a604e8fe5e8	0	20	f	\N	\N
fa0dbe0c-5a30-452d-bf0e-d8485c2e7c10	\N	\N	41afada5-8096-4d14-92f4-5079d0a42a1d	4d6c9170-5adb-40d8-98ac-2a604e8fe5e8	1	30	t	894b9f7e-2622-435c-b6aa-39066a83d417	\N
79162ba8-054f-4d8f-b608-934ecffecc5f	\N	conditional-user-configured	41afada5-8096-4d14-92f4-5079d0a42a1d	894b9f7e-2622-435c-b6aa-39066a83d417	0	10	f	\N	\N
c2d648cd-f49b-436b-9342-3168e85f128b	\N	direct-grant-validate-otp	41afada5-8096-4d14-92f4-5079d0a42a1d	894b9f7e-2622-435c-b6aa-39066a83d417	0	20	f	\N	\N
7dc3302b-43b4-464b-ae9a-bdee9ecae953	\N	registration-page-form	41afada5-8096-4d14-92f4-5079d0a42a1d	2d1f828f-bf85-4c12-af8f-3d860d66ffc9	0	10	t	c73a39bc-b17d-4a79-a125-c00ff6d8dacc	\N
572626f6-1862-4bf6-8fe9-d909bf97bcee	\N	registration-user-creation	41afada5-8096-4d14-92f4-5079d0a42a1d	c73a39bc-b17d-4a79-a125-c00ff6d8dacc	0	20	f	\N	\N
f439723a-3093-4ab3-9a2f-fce8cc130969	\N	registration-password-action	41afada5-8096-4d14-92f4-5079d0a42a1d	c73a39bc-b17d-4a79-a125-c00ff6d8dacc	0	50	f	\N	\N
403604fa-5047-464d-87d9-dd5075d6a9ea	\N	registration-recaptcha-action	41afada5-8096-4d14-92f4-5079d0a42a1d	c73a39bc-b17d-4a79-a125-c00ff6d8dacc	3	60	f	\N	\N
e9d84475-fb0e-4e05-8cdb-59b29c66cca9	\N	registration-terms-and-conditions	41afada5-8096-4d14-92f4-5079d0a42a1d	c73a39bc-b17d-4a79-a125-c00ff6d8dacc	3	70	f	\N	\N
d5d45c9e-186e-42ae-a677-2c4d8b63733f	\N	reset-credentials-choose-user	41afada5-8096-4d14-92f4-5079d0a42a1d	2b036c5b-af75-4b19-8803-8af703408438	0	10	f	\N	\N
c5d107aa-41ea-427b-844f-e7c008378cda	\N	reset-credential-email	41afada5-8096-4d14-92f4-5079d0a42a1d	2b036c5b-af75-4b19-8803-8af703408438	0	20	f	\N	\N
6d2df2ed-ae2e-4640-8785-7a9a8d27655c	\N	reset-password	41afada5-8096-4d14-92f4-5079d0a42a1d	2b036c5b-af75-4b19-8803-8af703408438	0	30	f	\N	\N
14474738-7050-48cb-aafa-062cebcf8ce9	\N	\N	41afada5-8096-4d14-92f4-5079d0a42a1d	2b036c5b-af75-4b19-8803-8af703408438	1	40	t	8446819f-64dd-43c2-8e61-ae31ed845389	\N
9dfd61ed-170f-44f3-8ca5-669d2f71f9d0	\N	conditional-user-configured	41afada5-8096-4d14-92f4-5079d0a42a1d	8446819f-64dd-43c2-8e61-ae31ed845389	0	10	f	\N	\N
115b2384-d566-470c-8dc3-f7e038f4494a	\N	reset-otp	41afada5-8096-4d14-92f4-5079d0a42a1d	8446819f-64dd-43c2-8e61-ae31ed845389	0	20	f	\N	\N
7b4785f4-04ac-4fd0-8631-124d369e5b88	\N	client-secret	41afada5-8096-4d14-92f4-5079d0a42a1d	cba30767-8fa7-41b4-aa14-24ac8a7e4d54	2	10	f	\N	\N
05113c34-2ad4-4c58-9842-7124348665c0	\N	client-jwt	41afada5-8096-4d14-92f4-5079d0a42a1d	cba30767-8fa7-41b4-aa14-24ac8a7e4d54	2	20	f	\N	\N
af4bec74-c9cd-49c3-b838-3e23c7fb21c0	\N	client-secret-jwt	41afada5-8096-4d14-92f4-5079d0a42a1d	cba30767-8fa7-41b4-aa14-24ac8a7e4d54	2	30	f	\N	\N
7b2cde63-b221-46f3-a503-5aeae6d26fd2	\N	client-x509	41afada5-8096-4d14-92f4-5079d0a42a1d	cba30767-8fa7-41b4-aa14-24ac8a7e4d54	2	40	f	\N	\N
ac1565b2-8152-4687-bbd6-5f03bace8bb9	\N	idp-review-profile	41afada5-8096-4d14-92f4-5079d0a42a1d	a1fe65de-3f0e-4dd6-aeef-37c6a44cc0a3	0	10	f	\N	2f7402fd-53e8-4ca5-a5b1-994c692b608b
3f953010-9843-4e72-9bd2-fa098d3478ef	\N	\N	41afada5-8096-4d14-92f4-5079d0a42a1d	a1fe65de-3f0e-4dd6-aeef-37c6a44cc0a3	0	20	t	5b9f2848-e8f4-44e7-a3b3-6289e0f1d047	\N
07b94a42-6d7d-422e-8809-1b94bec60df7	\N	idp-create-user-if-unique	41afada5-8096-4d14-92f4-5079d0a42a1d	5b9f2848-e8f4-44e7-a3b3-6289e0f1d047	2	10	f	\N	58ce2e63-ba87-4110-beba-76cdec03db44
d4b5d2ab-db81-440c-ae23-cac15642a157	\N	\N	41afada5-8096-4d14-92f4-5079d0a42a1d	5b9f2848-e8f4-44e7-a3b3-6289e0f1d047	2	20	t	623df5e0-9a98-4f7e-b52b-4b9106952510	\N
e3834e07-3dee-4f07-b1c7-54931554054e	\N	idp-confirm-link	41afada5-8096-4d14-92f4-5079d0a42a1d	623df5e0-9a98-4f7e-b52b-4b9106952510	0	10	f	\N	\N
f1b96323-213c-429d-a4b9-cadce69ca378	\N	\N	41afada5-8096-4d14-92f4-5079d0a42a1d	623df5e0-9a98-4f7e-b52b-4b9106952510	0	20	t	2b540e47-0241-4cad-ab80-7ae3d266ce66	\N
4355b3c1-9e7d-4e04-a0b7-b32547472c62	\N	idp-email-verification	41afada5-8096-4d14-92f4-5079d0a42a1d	2b540e47-0241-4cad-ab80-7ae3d266ce66	2	10	f	\N	\N
e16a6afb-2443-4c4f-accb-cda833b6306c	\N	\N	41afada5-8096-4d14-92f4-5079d0a42a1d	2b540e47-0241-4cad-ab80-7ae3d266ce66	2	20	t	1b8dd0e7-a2dd-4b1f-aa1a-a4c4db2fd349	\N
8aaee8cf-01d5-485e-b036-a71d1526bca9	\N	idp-username-password-form	41afada5-8096-4d14-92f4-5079d0a42a1d	1b8dd0e7-a2dd-4b1f-aa1a-a4c4db2fd349	0	10	f	\N	\N
5f23e39e-09d7-4390-b1ed-557ec85bc46a	\N	\N	41afada5-8096-4d14-92f4-5079d0a42a1d	1b8dd0e7-a2dd-4b1f-aa1a-a4c4db2fd349	1	20	t	093c017d-0242-4da7-a452-ecd520e6489e	\N
7ec06216-b4c9-4d35-9462-82e0df82f079	\N	conditional-user-configured	41afada5-8096-4d14-92f4-5079d0a42a1d	093c017d-0242-4da7-a452-ecd520e6489e	0	10	f	\N	\N
8f1a82c2-1908-49be-af9f-c58dd713ec30	\N	conditional-credential	41afada5-8096-4d14-92f4-5079d0a42a1d	093c017d-0242-4da7-a452-ecd520e6489e	0	20	f	\N	833ddc4f-eb30-46b4-b4e1-47a3530fa757
0f3af8f7-58e0-4135-9fb6-33b025720003	\N	auth-otp-form	41afada5-8096-4d14-92f4-5079d0a42a1d	093c017d-0242-4da7-a452-ecd520e6489e	2	30	f	\N	\N
52b8329d-53a0-4406-97a6-31866bef3a0d	\N	webauthn-authenticator	41afada5-8096-4d14-92f4-5079d0a42a1d	093c017d-0242-4da7-a452-ecd520e6489e	3	40	f	\N	\N
e859bdc3-fc16-4972-9493-693d0deb00d6	\N	auth-recovery-authn-code-form	41afada5-8096-4d14-92f4-5079d0a42a1d	093c017d-0242-4da7-a452-ecd520e6489e	3	50	f	\N	\N
a1b1def5-c3e1-4c2c-9ad8-2db1b1a9cfb4	\N	\N	41afada5-8096-4d14-92f4-5079d0a42a1d	a1fe65de-3f0e-4dd6-aeef-37c6a44cc0a3	1	60	t	9b96563f-6d32-4c92-933d-a8a954ae0d56	\N
63a4294e-ee9f-4e7d-8340-6d5943e2454c	\N	conditional-user-configured	41afada5-8096-4d14-92f4-5079d0a42a1d	9b96563f-6d32-4c92-933d-a8a954ae0d56	0	10	f	\N	\N
09b9142f-2863-4420-9b43-8e687413551b	\N	idp-add-organization-member	41afada5-8096-4d14-92f4-5079d0a42a1d	9b96563f-6d32-4c92-933d-a8a954ae0d56	0	20	f	\N	\N
ed5b8ebb-2d09-4bc0-89a2-d36615e05faa	\N	http-basic-authenticator	41afada5-8096-4d14-92f4-5079d0a42a1d	8920ec0f-4d8d-4c00-a9c8-a82be0bd25db	0	10	f	\N	\N
bfe60afc-8ca8-4052-9d2f-72cc55628656	\N	docker-http-basic-authenticator	41afada5-8096-4d14-92f4-5079d0a42a1d	cdc00aae-71a8-45b2-a5c2-723d8cd42ab6	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
f986a234-9c3d-4051-b136-67da440c527b	browser	Browser based authentication	451d845a-b81f-4125-b1b3-f3ec34d3cedb	basic-flow	t	t
77411224-e7f5-4149-86f7-be4bc5240e38	forms	Username, password, otp and other auth forms.	451d845a-b81f-4125-b1b3-f3ec34d3cedb	basic-flow	f	t
54c857c0-6293-46fc-b5e4-dc1934505e85	Browser - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	451d845a-b81f-4125-b1b3-f3ec34d3cedb	basic-flow	f	t
79d4859f-0f2c-4543-98c1-77549dc02f1d	direct grant	OpenID Connect Resource Owner Grant	451d845a-b81f-4125-b1b3-f3ec34d3cedb	basic-flow	t	t
fbc1e727-9fc1-4eb9-9168-05f2b975a11d	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	451d845a-b81f-4125-b1b3-f3ec34d3cedb	basic-flow	f	t
a461e5c1-7ad1-4810-8a5a-905a8d19be0b	registration	Registration flow	451d845a-b81f-4125-b1b3-f3ec34d3cedb	basic-flow	t	t
b5c28d77-fcbb-4b10-9369-3224ee417166	registration form	Registration form	451d845a-b81f-4125-b1b3-f3ec34d3cedb	form-flow	f	t
f192c125-2769-4a0c-94cf-dff08fd451a6	reset credentials	Reset credentials for a user if they forgot their password or something	451d845a-b81f-4125-b1b3-f3ec34d3cedb	basic-flow	t	t
6e2ac8cb-0c7e-4cf4-b174-0b1d1b23ebeb	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	451d845a-b81f-4125-b1b3-f3ec34d3cedb	basic-flow	f	t
7fde9135-8033-4736-a43f-a78c024b2125	clients	Base authentication for clients	451d845a-b81f-4125-b1b3-f3ec34d3cedb	client-flow	t	t
e694f4d3-d830-4546-8f9e-181e03e54c95	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	451d845a-b81f-4125-b1b3-f3ec34d3cedb	basic-flow	t	t
17e63ad6-96f8-4b57-8c8b-798281704600	User creation or linking	Flow for the existing/non-existing user alternatives	451d845a-b81f-4125-b1b3-f3ec34d3cedb	basic-flow	f	t
2e04c706-cf78-4911-b7e3-4b1087dd6bc3	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	451d845a-b81f-4125-b1b3-f3ec34d3cedb	basic-flow	f	t
d05a9e7c-cd7d-4ba6-9aab-1f0ca6429196	Account verification options	Method with which to verify the existing account	451d845a-b81f-4125-b1b3-f3ec34d3cedb	basic-flow	f	t
420792a6-4a0b-437b-98f1-d1c7d54f9bb9	Verify Existing Account by Re-authentication	Reauthentication of existing account	451d845a-b81f-4125-b1b3-f3ec34d3cedb	basic-flow	f	t
1dbe0b50-efdf-420f-b8da-5b7acef6d753	First broker login - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	451d845a-b81f-4125-b1b3-f3ec34d3cedb	basic-flow	f	t
b3ed8e65-acb1-4f26-915e-6566efea6d0a	saml ecp	SAML ECP Profile Authentication Flow	451d845a-b81f-4125-b1b3-f3ec34d3cedb	basic-flow	t	t
4ccec81c-90d7-4967-bb8f-59cdef8c890a	docker auth	Used by Docker clients to authenticate against the IDP	451d845a-b81f-4125-b1b3-f3ec34d3cedb	basic-flow	t	t
bfb14e97-5a56-496a-adfd-ea5224e9c95e	browser	Browser based authentication	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	t	t
82ac394f-8773-4023-8359-d970f41494a5	forms	Username, password, otp and other auth forms.	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	f	t
d82f3d3d-d66f-48fb-9d1b-03bf339bac03	Browser - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	f	t
66511c0d-1961-47c9-9f8f-1174cdddaa75	Organization	\N	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	f	t
261bdafd-3fcd-4551-afe0-99de0cac72f0	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	f	t
4d6c9170-5adb-40d8-98ac-2a604e8fe5e8	direct grant	OpenID Connect Resource Owner Grant	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	t	t
894b9f7e-2622-435c-b6aa-39066a83d417	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	f	t
2d1f828f-bf85-4c12-af8f-3d860d66ffc9	registration	Registration flow	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	t	t
c73a39bc-b17d-4a79-a125-c00ff6d8dacc	registration form	Registration form	41afada5-8096-4d14-92f4-5079d0a42a1d	form-flow	f	t
2b036c5b-af75-4b19-8803-8af703408438	reset credentials	Reset credentials for a user if they forgot their password or something	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	t	t
8446819f-64dd-43c2-8e61-ae31ed845389	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	f	t
cba30767-8fa7-41b4-aa14-24ac8a7e4d54	clients	Base authentication for clients	41afada5-8096-4d14-92f4-5079d0a42a1d	client-flow	t	t
a1fe65de-3f0e-4dd6-aeef-37c6a44cc0a3	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	t	t
5b9f2848-e8f4-44e7-a3b3-6289e0f1d047	User creation or linking	Flow for the existing/non-existing user alternatives	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	f	t
623df5e0-9a98-4f7e-b52b-4b9106952510	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	f	t
2b540e47-0241-4cad-ab80-7ae3d266ce66	Account verification options	Method with which to verify the existing account	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	f	t
1b8dd0e7-a2dd-4b1f-aa1a-a4c4db2fd349	Verify Existing Account by Re-authentication	Reauthentication of existing account	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	f	t
093c017d-0242-4da7-a452-ecd520e6489e	First broker login - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	f	t
9b96563f-6d32-4c92-933d-a8a954ae0d56	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	f	t
8920ec0f-4d8d-4c00-a9c8-a82be0bd25db	saml ecp	SAML ECP Profile Authentication Flow	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	t	t
cdc00aae-71a8-45b2-a5c2-723d8cd42ab6	docker auth	Used by Docker clients to authenticate against the IDP	41afada5-8096-4d14-92f4-5079d0a42a1d	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
0d7ba54f-0fb6-4a68-bb1f-71358a358a74	browser-conditional-credential	451d845a-b81f-4125-b1b3-f3ec34d3cedb
2ed50cdc-9757-4c73-89b5-5164f30861f0	review profile config	451d845a-b81f-4125-b1b3-f3ec34d3cedb
41785f9c-4e54-48ab-bf4e-0930e738c16e	create unique user config	451d845a-b81f-4125-b1b3-f3ec34d3cedb
0cb9c4cf-82b2-45f0-a8fb-efd9d71174fc	first-broker-login-conditional-credential	451d845a-b81f-4125-b1b3-f3ec34d3cedb
63a5bd44-efb3-4bf8-895c-278c3df1887d	browser-conditional-credential	41afada5-8096-4d14-92f4-5079d0a42a1d
2f7402fd-53e8-4ca5-a5b1-994c692b608b	review profile config	41afada5-8096-4d14-92f4-5079d0a42a1d
58ce2e63-ba87-4110-beba-76cdec03db44	create unique user config	41afada5-8096-4d14-92f4-5079d0a42a1d
833ddc4f-eb30-46b4-b4e1-47a3530fa757	first-broker-login-conditional-credential	41afada5-8096-4d14-92f4-5079d0a42a1d
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
0cb9c4cf-82b2-45f0-a8fb-efd9d71174fc	webauthn-passwordless	credentials
0d7ba54f-0fb6-4a68-bb1f-71358a358a74	webauthn-passwordless	credentials
2ed50cdc-9757-4c73-89b5-5164f30861f0	missing	update.profile.on.first.login
41785f9c-4e54-48ab-bf4e-0930e738c16e	false	require.password.update.after.registration
2f7402fd-53e8-4ca5-a5b1-994c692b608b	missing	update.profile.on.first.login
58ce2e63-ba87-4110-beba-76cdec03db44	false	require.password.update.after.registration
63a5bd44-efb3-4bf8-895c-278c3df1887d	webauthn-passwordless	credentials
833ddc4f-eb30-46b4-b4e1-47a3530fa757	webauthn-passwordless	credentials
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	f	master-realm	0	f	\N	\N	t	\N	f	451d845a-b81f-4125-b1b3-f3ec34d3cedb	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
aa93bd47-f839-4238-b0b0-fd0b9191ee08	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	451d845a-b81f-4125-b1b3-f3ec34d3cedb	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	451d845a-b81f-4125-b1b3-f3ec34d3cedb	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
329e25c4-7e70-43eb-ab08-94d2cad785ee	t	f	broker	0	f	\N	\N	t	\N	f	451d845a-b81f-4125-b1b3-f3ec34d3cedb	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	451d845a-b81f-4125-b1b3-f3ec34d3cedb	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
09262b48-1da1-4b8a-8522-ac49e51f9116	t	t	admin-cli	0	t	\N	\N	f	\N	f	451d845a-b81f-4125-b1b3-f3ec34d3cedb	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	f	realm-management	0	f	\N	\N	t	\N	f	41afada5-8096-4d14-92f4-5079d0a42a1d	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
ba53fa6d-43a7-46e9-8c75-adf9db8a3b1d	t	f	broker	0	f	\N	\N	t	\N	f	41afada5-8096-4d14-92f4-5079d0a42a1d	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
4d47f8cc-1907-404d-a357-854172a145b3	t	t	admin-cli	0	t	\N	\N	f	\N	f	41afada5-8096-4d14-92f4-5079d0a42a1d	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	t	t	stock-web	0	t	\N		f	http://localhost:4200	f	41afada5-8096-4d14-92f4-5079d0a42a1d	openid-connect	-1	t	f		f	client-secret	http://localhost:4200		\N	t	f	f	f
39e121f1-0761-4d07-a046-8364e8007116	t	f	stock-control-realm-realm	0	f	\N	\N	t	\N	f	451d845a-b81f-4125-b1b3-f3ec34d3cedb	\N	0	f	f	stock-control-realm Realm	f	client-secret	\N	\N	\N	t	f	f	f
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	t	t	security-admin-console	0	t	\N	/admin/stock-control-realm/console/	f	\N	f	41afada5-8096-4d14-92f4-5079d0a42a1d	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	t	f	account	0	t	\N	/realms/stock-control-realm/account/	f	\N	f	41afada5-8096-4d14-92f4-5079d0a42a1d	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	t	f	account-console	0	t	\N	/realms/stock-control-realm/account/	f	\N	f	41afada5-8096-4d14-92f4-5079d0a42a1d	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
aa93bd47-f839-4238-b0b0-fd0b9191ee08	post.logout.redirect.uris	+
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	post.logout.redirect.uris	+
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	pkce.code.challenge.method	S256
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	post.logout.redirect.uris	+
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	pkce.code.challenge.method	S256
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	client.use.lightweight.access.token.enabled	true
09262b48-1da1-4b8a-8522-ac49e51f9116	client.use.lightweight.access.token.enabled	true
bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	post.logout.redirect.uris	+
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	post.logout.redirect.uris	+
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	pkce.code.challenge.method	S256
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	post.logout.redirect.uris	+
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	pkce.code.challenge.method	S256
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	client.use.lightweight.access.token.enabled	true
4d47f8cc-1907-404d-a357-854172a145b3	client.use.lightweight.access.token.enabled	true
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	standard.token.exchange.enabled	false
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	oauth2.device.authorization.grant.enabled	false
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	oidc.ciba.grant.enabled	false
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	dpop.bound.access.tokens	false
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	backchannel.logout.session.required	true
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	backchannel.logout.revoke.offline.tokens	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
b3c0ba04-1417-4a96-a8b1-2c4463d60e72	offline_access	451d845a-b81f-4125-b1b3-f3ec34d3cedb	OpenID Connect built-in scope: offline_access	openid-connect
1790ddde-c126-4fa5-a371-c75359a7410f	role_list	451d845a-b81f-4125-b1b3-f3ec34d3cedb	SAML role list	saml
2434f2de-a467-4d4e-be26-907104d937fe	saml_organization	451d845a-b81f-4125-b1b3-f3ec34d3cedb	Organization Membership	saml
b3fe39a2-aa3c-4200-b1aa-35faec841819	profile	451d845a-b81f-4125-b1b3-f3ec34d3cedb	OpenID Connect built-in scope: profile	openid-connect
43b012ea-8f15-45d6-8463-e712cfc02822	email	451d845a-b81f-4125-b1b3-f3ec34d3cedb	OpenID Connect built-in scope: email	openid-connect
094a2f4f-5d0d-4050-90ee-e20afc0a13f1	address	451d845a-b81f-4125-b1b3-f3ec34d3cedb	OpenID Connect built-in scope: address	openid-connect
4ede134c-da0c-47e1-b344-33a7bf9b2217	phone	451d845a-b81f-4125-b1b3-f3ec34d3cedb	OpenID Connect built-in scope: phone	openid-connect
2a28a7db-ed93-4f8c-9dcd-11d90420bb1c	roles	451d845a-b81f-4125-b1b3-f3ec34d3cedb	OpenID Connect scope for add user roles to the access token	openid-connect
819e2766-bafc-4fc2-af59-c425c564c7cb	web-origins	451d845a-b81f-4125-b1b3-f3ec34d3cedb	OpenID Connect scope for add allowed web origins to the access token	openid-connect
a795626b-abcb-4b56-96c6-e919a6c6df56	microprofile-jwt	451d845a-b81f-4125-b1b3-f3ec34d3cedb	Microprofile - JWT built-in scope	openid-connect
ef06f1e6-4fb4-4790-97da-9cb81863e782	acr	451d845a-b81f-4125-b1b3-f3ec34d3cedb	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
d15b0017-265e-4ce5-99a0-d8a4d94ce4a0	basic	451d845a-b81f-4125-b1b3-f3ec34d3cedb	OpenID Connect scope for add all basic claims to the token	openid-connect
99b3fe20-a636-4917-8579-0aa5821450ec	service_account	451d845a-b81f-4125-b1b3-f3ec34d3cedb	Specific scope for a client enabled for service accounts	openid-connect
875bb6d8-7080-4498-9e56-413f752ca4db	organization	451d845a-b81f-4125-b1b3-f3ec34d3cedb	Additional claims about the organization a subject belongs to	openid-connect
09e2e827-08d2-4307-8cfc-154232c0ed0d	offline_access	41afada5-8096-4d14-92f4-5079d0a42a1d	OpenID Connect built-in scope: offline_access	openid-connect
45f67aaf-3565-4e03-9a71-b8dd543a3fe4	role_list	41afada5-8096-4d14-92f4-5079d0a42a1d	SAML role list	saml
431f950b-5b82-49f5-8c04-3008be7e32b9	saml_organization	41afada5-8096-4d14-92f4-5079d0a42a1d	Organization Membership	saml
0b612215-750f-4d9d-b909-46f4e0a54109	profile	41afada5-8096-4d14-92f4-5079d0a42a1d	OpenID Connect built-in scope: profile	openid-connect
53c5f94b-f304-4ca3-88f1-3f70149806fc	email	41afada5-8096-4d14-92f4-5079d0a42a1d	OpenID Connect built-in scope: email	openid-connect
4093ec20-f746-47c5-b92c-52eb67725380	address	41afada5-8096-4d14-92f4-5079d0a42a1d	OpenID Connect built-in scope: address	openid-connect
37690b89-3dbf-4c0d-a02c-fee95835be61	phone	41afada5-8096-4d14-92f4-5079d0a42a1d	OpenID Connect built-in scope: phone	openid-connect
79ff0bbd-45e6-4fbc-99da-d34ff22a6c14	roles	41afada5-8096-4d14-92f4-5079d0a42a1d	OpenID Connect scope for add user roles to the access token	openid-connect
d6f48ab8-ab41-45a8-a64b-9dd638c7ff5f	web-origins	41afada5-8096-4d14-92f4-5079d0a42a1d	OpenID Connect scope for add allowed web origins to the access token	openid-connect
eb0bb277-713d-4a98-b782-a5b092d5ca75	microprofile-jwt	41afada5-8096-4d14-92f4-5079d0a42a1d	Microprofile - JWT built-in scope	openid-connect
6f0404c5-c6dd-4ea1-b145-591fe85595b6	acr	41afada5-8096-4d14-92f4-5079d0a42a1d	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
b01e43af-0983-45b6-82a4-5cfa88d15700	basic	41afada5-8096-4d14-92f4-5079d0a42a1d	OpenID Connect scope for add all basic claims to the token	openid-connect
fffe9976-b280-4c5f-8705-2be08afae48f	service_account	41afada5-8096-4d14-92f4-5079d0a42a1d	Specific scope for a client enabled for service accounts	openid-connect
3bf3c4d0-659b-4a7a-9e0a-614aba646317	organization	41afada5-8096-4d14-92f4-5079d0a42a1d	Additional claims about the organization a subject belongs to	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
b3c0ba04-1417-4a96-a8b1-2c4463d60e72	true	display.on.consent.screen
b3c0ba04-1417-4a96-a8b1-2c4463d60e72	${offlineAccessScopeConsentText}	consent.screen.text
1790ddde-c126-4fa5-a371-c75359a7410f	true	display.on.consent.screen
1790ddde-c126-4fa5-a371-c75359a7410f	${samlRoleListScopeConsentText}	consent.screen.text
2434f2de-a467-4d4e-be26-907104d937fe	false	display.on.consent.screen
b3fe39a2-aa3c-4200-b1aa-35faec841819	true	display.on.consent.screen
b3fe39a2-aa3c-4200-b1aa-35faec841819	${profileScopeConsentText}	consent.screen.text
b3fe39a2-aa3c-4200-b1aa-35faec841819	true	include.in.token.scope
43b012ea-8f15-45d6-8463-e712cfc02822	true	display.on.consent.screen
43b012ea-8f15-45d6-8463-e712cfc02822	${emailScopeConsentText}	consent.screen.text
43b012ea-8f15-45d6-8463-e712cfc02822	true	include.in.token.scope
094a2f4f-5d0d-4050-90ee-e20afc0a13f1	true	display.on.consent.screen
094a2f4f-5d0d-4050-90ee-e20afc0a13f1	${addressScopeConsentText}	consent.screen.text
094a2f4f-5d0d-4050-90ee-e20afc0a13f1	true	include.in.token.scope
4ede134c-da0c-47e1-b344-33a7bf9b2217	true	display.on.consent.screen
4ede134c-da0c-47e1-b344-33a7bf9b2217	${phoneScopeConsentText}	consent.screen.text
4ede134c-da0c-47e1-b344-33a7bf9b2217	true	include.in.token.scope
2a28a7db-ed93-4f8c-9dcd-11d90420bb1c	true	display.on.consent.screen
2a28a7db-ed93-4f8c-9dcd-11d90420bb1c	${rolesScopeConsentText}	consent.screen.text
2a28a7db-ed93-4f8c-9dcd-11d90420bb1c	false	include.in.token.scope
819e2766-bafc-4fc2-af59-c425c564c7cb	false	display.on.consent.screen
819e2766-bafc-4fc2-af59-c425c564c7cb		consent.screen.text
819e2766-bafc-4fc2-af59-c425c564c7cb	false	include.in.token.scope
a795626b-abcb-4b56-96c6-e919a6c6df56	false	display.on.consent.screen
a795626b-abcb-4b56-96c6-e919a6c6df56	true	include.in.token.scope
ef06f1e6-4fb4-4790-97da-9cb81863e782	false	display.on.consent.screen
ef06f1e6-4fb4-4790-97da-9cb81863e782	false	include.in.token.scope
d15b0017-265e-4ce5-99a0-d8a4d94ce4a0	false	display.on.consent.screen
d15b0017-265e-4ce5-99a0-d8a4d94ce4a0	false	include.in.token.scope
99b3fe20-a636-4917-8579-0aa5821450ec	false	display.on.consent.screen
99b3fe20-a636-4917-8579-0aa5821450ec	false	include.in.token.scope
875bb6d8-7080-4498-9e56-413f752ca4db	true	display.on.consent.screen
875bb6d8-7080-4498-9e56-413f752ca4db	${organizationScopeConsentText}	consent.screen.text
875bb6d8-7080-4498-9e56-413f752ca4db	true	include.in.token.scope
09e2e827-08d2-4307-8cfc-154232c0ed0d	true	display.on.consent.screen
09e2e827-08d2-4307-8cfc-154232c0ed0d	${offlineAccessScopeConsentText}	consent.screen.text
45f67aaf-3565-4e03-9a71-b8dd543a3fe4	true	display.on.consent.screen
45f67aaf-3565-4e03-9a71-b8dd543a3fe4	${samlRoleListScopeConsentText}	consent.screen.text
431f950b-5b82-49f5-8c04-3008be7e32b9	false	display.on.consent.screen
0b612215-750f-4d9d-b909-46f4e0a54109	true	display.on.consent.screen
0b612215-750f-4d9d-b909-46f4e0a54109	${profileScopeConsentText}	consent.screen.text
0b612215-750f-4d9d-b909-46f4e0a54109	true	include.in.token.scope
53c5f94b-f304-4ca3-88f1-3f70149806fc	true	display.on.consent.screen
53c5f94b-f304-4ca3-88f1-3f70149806fc	${emailScopeConsentText}	consent.screen.text
53c5f94b-f304-4ca3-88f1-3f70149806fc	true	include.in.token.scope
4093ec20-f746-47c5-b92c-52eb67725380	true	display.on.consent.screen
4093ec20-f746-47c5-b92c-52eb67725380	${addressScopeConsentText}	consent.screen.text
4093ec20-f746-47c5-b92c-52eb67725380	true	include.in.token.scope
37690b89-3dbf-4c0d-a02c-fee95835be61	true	display.on.consent.screen
37690b89-3dbf-4c0d-a02c-fee95835be61	${phoneScopeConsentText}	consent.screen.text
37690b89-3dbf-4c0d-a02c-fee95835be61	true	include.in.token.scope
79ff0bbd-45e6-4fbc-99da-d34ff22a6c14	true	display.on.consent.screen
79ff0bbd-45e6-4fbc-99da-d34ff22a6c14	${rolesScopeConsentText}	consent.screen.text
79ff0bbd-45e6-4fbc-99da-d34ff22a6c14	false	include.in.token.scope
d6f48ab8-ab41-45a8-a64b-9dd638c7ff5f	false	display.on.consent.screen
d6f48ab8-ab41-45a8-a64b-9dd638c7ff5f		consent.screen.text
d6f48ab8-ab41-45a8-a64b-9dd638c7ff5f	false	include.in.token.scope
eb0bb277-713d-4a98-b782-a5b092d5ca75	false	display.on.consent.screen
eb0bb277-713d-4a98-b782-a5b092d5ca75	true	include.in.token.scope
6f0404c5-c6dd-4ea1-b145-591fe85595b6	false	display.on.consent.screen
6f0404c5-c6dd-4ea1-b145-591fe85595b6	false	include.in.token.scope
b01e43af-0983-45b6-82a4-5cfa88d15700	false	display.on.consent.screen
b01e43af-0983-45b6-82a4-5cfa88d15700	false	include.in.token.scope
fffe9976-b280-4c5f-8705-2be08afae48f	false	display.on.consent.screen
fffe9976-b280-4c5f-8705-2be08afae48f	false	include.in.token.scope
3bf3c4d0-659b-4a7a-9e0a-614aba646317	true	display.on.consent.screen
3bf3c4d0-659b-4a7a-9e0a-614aba646317	${organizationScopeConsentText}	consent.screen.text
3bf3c4d0-659b-4a7a-9e0a-614aba646317	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
aa93bd47-f839-4238-b0b0-fd0b9191ee08	2a28a7db-ed93-4f8c-9dcd-11d90420bb1c	t
aa93bd47-f839-4238-b0b0-fd0b9191ee08	ef06f1e6-4fb4-4790-97da-9cb81863e782	t
aa93bd47-f839-4238-b0b0-fd0b9191ee08	d15b0017-265e-4ce5-99a0-d8a4d94ce4a0	t
aa93bd47-f839-4238-b0b0-fd0b9191ee08	43b012ea-8f15-45d6-8463-e712cfc02822	t
aa93bd47-f839-4238-b0b0-fd0b9191ee08	b3fe39a2-aa3c-4200-b1aa-35faec841819	t
aa93bd47-f839-4238-b0b0-fd0b9191ee08	819e2766-bafc-4fc2-af59-c425c564c7cb	t
aa93bd47-f839-4238-b0b0-fd0b9191ee08	b3c0ba04-1417-4a96-a8b1-2c4463d60e72	f
aa93bd47-f839-4238-b0b0-fd0b9191ee08	094a2f4f-5d0d-4050-90ee-e20afc0a13f1	f
aa93bd47-f839-4238-b0b0-fd0b9191ee08	875bb6d8-7080-4498-9e56-413f752ca4db	f
aa93bd47-f839-4238-b0b0-fd0b9191ee08	a795626b-abcb-4b56-96c6-e919a6c6df56	f
aa93bd47-f839-4238-b0b0-fd0b9191ee08	4ede134c-da0c-47e1-b344-33a7bf9b2217	f
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	2a28a7db-ed93-4f8c-9dcd-11d90420bb1c	t
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	ef06f1e6-4fb4-4790-97da-9cb81863e782	t
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	d15b0017-265e-4ce5-99a0-d8a4d94ce4a0	t
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	43b012ea-8f15-45d6-8463-e712cfc02822	t
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	b3fe39a2-aa3c-4200-b1aa-35faec841819	t
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	819e2766-bafc-4fc2-af59-c425c564c7cb	t
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	b3c0ba04-1417-4a96-a8b1-2c4463d60e72	f
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	094a2f4f-5d0d-4050-90ee-e20afc0a13f1	f
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	875bb6d8-7080-4498-9e56-413f752ca4db	f
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	a795626b-abcb-4b56-96c6-e919a6c6df56	f
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	4ede134c-da0c-47e1-b344-33a7bf9b2217	f
09262b48-1da1-4b8a-8522-ac49e51f9116	2a28a7db-ed93-4f8c-9dcd-11d90420bb1c	t
09262b48-1da1-4b8a-8522-ac49e51f9116	ef06f1e6-4fb4-4790-97da-9cb81863e782	t
09262b48-1da1-4b8a-8522-ac49e51f9116	d15b0017-265e-4ce5-99a0-d8a4d94ce4a0	t
09262b48-1da1-4b8a-8522-ac49e51f9116	43b012ea-8f15-45d6-8463-e712cfc02822	t
09262b48-1da1-4b8a-8522-ac49e51f9116	b3fe39a2-aa3c-4200-b1aa-35faec841819	t
09262b48-1da1-4b8a-8522-ac49e51f9116	819e2766-bafc-4fc2-af59-c425c564c7cb	t
09262b48-1da1-4b8a-8522-ac49e51f9116	b3c0ba04-1417-4a96-a8b1-2c4463d60e72	f
09262b48-1da1-4b8a-8522-ac49e51f9116	094a2f4f-5d0d-4050-90ee-e20afc0a13f1	f
09262b48-1da1-4b8a-8522-ac49e51f9116	875bb6d8-7080-4498-9e56-413f752ca4db	f
09262b48-1da1-4b8a-8522-ac49e51f9116	a795626b-abcb-4b56-96c6-e919a6c6df56	f
09262b48-1da1-4b8a-8522-ac49e51f9116	4ede134c-da0c-47e1-b344-33a7bf9b2217	f
329e25c4-7e70-43eb-ab08-94d2cad785ee	2a28a7db-ed93-4f8c-9dcd-11d90420bb1c	t
329e25c4-7e70-43eb-ab08-94d2cad785ee	ef06f1e6-4fb4-4790-97da-9cb81863e782	t
329e25c4-7e70-43eb-ab08-94d2cad785ee	d15b0017-265e-4ce5-99a0-d8a4d94ce4a0	t
329e25c4-7e70-43eb-ab08-94d2cad785ee	43b012ea-8f15-45d6-8463-e712cfc02822	t
329e25c4-7e70-43eb-ab08-94d2cad785ee	b3fe39a2-aa3c-4200-b1aa-35faec841819	t
329e25c4-7e70-43eb-ab08-94d2cad785ee	819e2766-bafc-4fc2-af59-c425c564c7cb	t
329e25c4-7e70-43eb-ab08-94d2cad785ee	b3c0ba04-1417-4a96-a8b1-2c4463d60e72	f
329e25c4-7e70-43eb-ab08-94d2cad785ee	094a2f4f-5d0d-4050-90ee-e20afc0a13f1	f
329e25c4-7e70-43eb-ab08-94d2cad785ee	875bb6d8-7080-4498-9e56-413f752ca4db	f
329e25c4-7e70-43eb-ab08-94d2cad785ee	a795626b-abcb-4b56-96c6-e919a6c6df56	f
329e25c4-7e70-43eb-ab08-94d2cad785ee	4ede134c-da0c-47e1-b344-33a7bf9b2217	f
d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	2a28a7db-ed93-4f8c-9dcd-11d90420bb1c	t
d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	ef06f1e6-4fb4-4790-97da-9cb81863e782	t
d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	d15b0017-265e-4ce5-99a0-d8a4d94ce4a0	t
d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	43b012ea-8f15-45d6-8463-e712cfc02822	t
d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	b3fe39a2-aa3c-4200-b1aa-35faec841819	t
d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	819e2766-bafc-4fc2-af59-c425c564c7cb	t
d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	b3c0ba04-1417-4a96-a8b1-2c4463d60e72	f
d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	094a2f4f-5d0d-4050-90ee-e20afc0a13f1	f
d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	875bb6d8-7080-4498-9e56-413f752ca4db	f
d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	a795626b-abcb-4b56-96c6-e919a6c6df56	f
d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	4ede134c-da0c-47e1-b344-33a7bf9b2217	f
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	2a28a7db-ed93-4f8c-9dcd-11d90420bb1c	t
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	ef06f1e6-4fb4-4790-97da-9cb81863e782	t
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	d15b0017-265e-4ce5-99a0-d8a4d94ce4a0	t
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	43b012ea-8f15-45d6-8463-e712cfc02822	t
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	b3fe39a2-aa3c-4200-b1aa-35faec841819	t
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	819e2766-bafc-4fc2-af59-c425c564c7cb	t
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	b3c0ba04-1417-4a96-a8b1-2c4463d60e72	f
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	094a2f4f-5d0d-4050-90ee-e20afc0a13f1	f
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	875bb6d8-7080-4498-9e56-413f752ca4db	f
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	a795626b-abcb-4b56-96c6-e919a6c6df56	f
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	4ede134c-da0c-47e1-b344-33a7bf9b2217	f
bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	d6f48ab8-ab41-45a8-a64b-9dd638c7ff5f	t
bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	b01e43af-0983-45b6-82a4-5cfa88d15700	t
bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	6f0404c5-c6dd-4ea1-b145-591fe85595b6	t
bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	0b612215-750f-4d9d-b909-46f4e0a54109	t
bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	79ff0bbd-45e6-4fbc-99da-d34ff22a6c14	t
bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	53c5f94b-f304-4ca3-88f1-3f70149806fc	t
bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	eb0bb277-713d-4a98-b782-a5b092d5ca75	f
bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	4093ec20-f746-47c5-b92c-52eb67725380	f
bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	37690b89-3dbf-4c0d-a02c-fee95835be61	f
bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	09e2e827-08d2-4307-8cfc-154232c0ed0d	f
bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	3bf3c4d0-659b-4a7a-9e0a-614aba646317	f
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	d6f48ab8-ab41-45a8-a64b-9dd638c7ff5f	t
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	b01e43af-0983-45b6-82a4-5cfa88d15700	t
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	6f0404c5-c6dd-4ea1-b145-591fe85595b6	t
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	0b612215-750f-4d9d-b909-46f4e0a54109	t
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	79ff0bbd-45e6-4fbc-99da-d34ff22a6c14	t
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	53c5f94b-f304-4ca3-88f1-3f70149806fc	t
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	eb0bb277-713d-4a98-b782-a5b092d5ca75	f
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	4093ec20-f746-47c5-b92c-52eb67725380	f
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	37690b89-3dbf-4c0d-a02c-fee95835be61	f
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	09e2e827-08d2-4307-8cfc-154232c0ed0d	f
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	3bf3c4d0-659b-4a7a-9e0a-614aba646317	f
4d47f8cc-1907-404d-a357-854172a145b3	d6f48ab8-ab41-45a8-a64b-9dd638c7ff5f	t
4d47f8cc-1907-404d-a357-854172a145b3	b01e43af-0983-45b6-82a4-5cfa88d15700	t
4d47f8cc-1907-404d-a357-854172a145b3	6f0404c5-c6dd-4ea1-b145-591fe85595b6	t
4d47f8cc-1907-404d-a357-854172a145b3	0b612215-750f-4d9d-b909-46f4e0a54109	t
4d47f8cc-1907-404d-a357-854172a145b3	79ff0bbd-45e6-4fbc-99da-d34ff22a6c14	t
4d47f8cc-1907-404d-a357-854172a145b3	53c5f94b-f304-4ca3-88f1-3f70149806fc	t
4d47f8cc-1907-404d-a357-854172a145b3	eb0bb277-713d-4a98-b782-a5b092d5ca75	f
4d47f8cc-1907-404d-a357-854172a145b3	4093ec20-f746-47c5-b92c-52eb67725380	f
4d47f8cc-1907-404d-a357-854172a145b3	37690b89-3dbf-4c0d-a02c-fee95835be61	f
4d47f8cc-1907-404d-a357-854172a145b3	09e2e827-08d2-4307-8cfc-154232c0ed0d	f
4d47f8cc-1907-404d-a357-854172a145b3	3bf3c4d0-659b-4a7a-9e0a-614aba646317	f
ba53fa6d-43a7-46e9-8c75-adf9db8a3b1d	d6f48ab8-ab41-45a8-a64b-9dd638c7ff5f	t
ba53fa6d-43a7-46e9-8c75-adf9db8a3b1d	b01e43af-0983-45b6-82a4-5cfa88d15700	t
ba53fa6d-43a7-46e9-8c75-adf9db8a3b1d	6f0404c5-c6dd-4ea1-b145-591fe85595b6	t
ba53fa6d-43a7-46e9-8c75-adf9db8a3b1d	0b612215-750f-4d9d-b909-46f4e0a54109	t
ba53fa6d-43a7-46e9-8c75-adf9db8a3b1d	79ff0bbd-45e6-4fbc-99da-d34ff22a6c14	t
ba53fa6d-43a7-46e9-8c75-adf9db8a3b1d	53c5f94b-f304-4ca3-88f1-3f70149806fc	t
ba53fa6d-43a7-46e9-8c75-adf9db8a3b1d	eb0bb277-713d-4a98-b782-a5b092d5ca75	f
ba53fa6d-43a7-46e9-8c75-adf9db8a3b1d	4093ec20-f746-47c5-b92c-52eb67725380	f
ba53fa6d-43a7-46e9-8c75-adf9db8a3b1d	37690b89-3dbf-4c0d-a02c-fee95835be61	f
ba53fa6d-43a7-46e9-8c75-adf9db8a3b1d	09e2e827-08d2-4307-8cfc-154232c0ed0d	f
ba53fa6d-43a7-46e9-8c75-adf9db8a3b1d	3bf3c4d0-659b-4a7a-9e0a-614aba646317	f
8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	d6f48ab8-ab41-45a8-a64b-9dd638c7ff5f	t
8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	b01e43af-0983-45b6-82a4-5cfa88d15700	t
8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	6f0404c5-c6dd-4ea1-b145-591fe85595b6	t
8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	0b612215-750f-4d9d-b909-46f4e0a54109	t
8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	79ff0bbd-45e6-4fbc-99da-d34ff22a6c14	t
8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	53c5f94b-f304-4ca3-88f1-3f70149806fc	t
8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	eb0bb277-713d-4a98-b782-a5b092d5ca75	f
8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	4093ec20-f746-47c5-b92c-52eb67725380	f
8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	37690b89-3dbf-4c0d-a02c-fee95835be61	f
8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	09e2e827-08d2-4307-8cfc-154232c0ed0d	f
8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	3bf3c4d0-659b-4a7a-9e0a-614aba646317	f
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	d6f48ab8-ab41-45a8-a64b-9dd638c7ff5f	t
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	b01e43af-0983-45b6-82a4-5cfa88d15700	t
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	6f0404c5-c6dd-4ea1-b145-591fe85595b6	t
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	0b612215-750f-4d9d-b909-46f4e0a54109	t
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	79ff0bbd-45e6-4fbc-99da-d34ff22a6c14	t
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	53c5f94b-f304-4ca3-88f1-3f70149806fc	t
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	eb0bb277-713d-4a98-b782-a5b092d5ca75	f
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	4093ec20-f746-47c5-b92c-52eb67725380	f
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	37690b89-3dbf-4c0d-a02c-fee95835be61	f
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	09e2e827-08d2-4307-8cfc-154232c0ed0d	f
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	3bf3c4d0-659b-4a7a-9e0a-614aba646317	f
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	d6f48ab8-ab41-45a8-a64b-9dd638c7ff5f	t
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	b01e43af-0983-45b6-82a4-5cfa88d15700	t
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	6f0404c5-c6dd-4ea1-b145-591fe85595b6	t
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	0b612215-750f-4d9d-b909-46f4e0a54109	t
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	79ff0bbd-45e6-4fbc-99da-d34ff22a6c14	t
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	53c5f94b-f304-4ca3-88f1-3f70149806fc	t
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	eb0bb277-713d-4a98-b782-a5b092d5ca75	f
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	4093ec20-f746-47c5-b92c-52eb67725380	f
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	37690b89-3dbf-4c0d-a02c-fee95835be61	f
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	09e2e827-08d2-4307-8cfc-154232c0ed0d	f
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	3bf3c4d0-659b-4a7a-9e0a-614aba646317	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
b3c0ba04-1417-4a96-a8b1-2c4463d60e72	8478cda7-e6fe-41bb-bc75-780473d6af86
09e2e827-08d2-4307-8cfc-154232c0ed0d	c2dca058-7202-4620-b0e0-db3442247fc4
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
4e7f3e21-5117-4ef5-9f2d-01fccb2c126f	Trusted Hosts	451d845a-b81f-4125-b1b3-f3ec34d3cedb	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	451d845a-b81f-4125-b1b3-f3ec34d3cedb	anonymous
182de508-c4ae-4101-875c-f801047aca8c	Consent Required	451d845a-b81f-4125-b1b3-f3ec34d3cedb	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	451d845a-b81f-4125-b1b3-f3ec34d3cedb	anonymous
f059991f-e1f9-40ee-9a58-820aa73c14fd	Full Scope Disabled	451d845a-b81f-4125-b1b3-f3ec34d3cedb	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	451d845a-b81f-4125-b1b3-f3ec34d3cedb	anonymous
e2f1126f-ae81-4817-a2fe-de6ee70b2a1d	Max Clients Limit	451d845a-b81f-4125-b1b3-f3ec34d3cedb	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	451d845a-b81f-4125-b1b3-f3ec34d3cedb	anonymous
092acf98-bf1d-459d-b655-286304e23253	Allowed Protocol Mapper Types	451d845a-b81f-4125-b1b3-f3ec34d3cedb	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	451d845a-b81f-4125-b1b3-f3ec34d3cedb	anonymous
de842030-9c59-4aa7-a5e9-75b6340b3b31	Allowed Client Scopes	451d845a-b81f-4125-b1b3-f3ec34d3cedb	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	451d845a-b81f-4125-b1b3-f3ec34d3cedb	anonymous
11abf94e-a0f8-492f-82d0-343c6573c275	Allowed Registration Web Origins	451d845a-b81f-4125-b1b3-f3ec34d3cedb	registration-web-origins	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	451d845a-b81f-4125-b1b3-f3ec34d3cedb	anonymous
5799d0b3-bd63-4d10-8179-6a21aa3aa6f5	Allowed Protocol Mapper Types	451d845a-b81f-4125-b1b3-f3ec34d3cedb	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	451d845a-b81f-4125-b1b3-f3ec34d3cedb	authenticated
d650dae2-a6a6-488a-97d5-6f81bd71433f	Allowed Client Scopes	451d845a-b81f-4125-b1b3-f3ec34d3cedb	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	451d845a-b81f-4125-b1b3-f3ec34d3cedb	authenticated
5bc43619-f66e-4809-aa6d-0028a9ac39ed	Allowed Registration Web Origins	451d845a-b81f-4125-b1b3-f3ec34d3cedb	registration-web-origins	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	451d845a-b81f-4125-b1b3-f3ec34d3cedb	authenticated
36fd086d-94d3-471c-b34c-bc65d12ced97	rsa-generated	451d845a-b81f-4125-b1b3-f3ec34d3cedb	rsa-generated	org.keycloak.keys.KeyProvider	451d845a-b81f-4125-b1b3-f3ec34d3cedb	\N
ef7f1b01-b21a-48ad-ac7c-3f22a7592452	rsa-enc-generated	451d845a-b81f-4125-b1b3-f3ec34d3cedb	rsa-enc-generated	org.keycloak.keys.KeyProvider	451d845a-b81f-4125-b1b3-f3ec34d3cedb	\N
4d26cb02-f575-47be-b952-d83b49adb9cc	hmac-generated-hs512	451d845a-b81f-4125-b1b3-f3ec34d3cedb	hmac-generated	org.keycloak.keys.KeyProvider	451d845a-b81f-4125-b1b3-f3ec34d3cedb	\N
c63c14d6-2dc2-47ad-98d0-5f19d2bd6b1d	aes-generated	451d845a-b81f-4125-b1b3-f3ec34d3cedb	aes-generated	org.keycloak.keys.KeyProvider	451d845a-b81f-4125-b1b3-f3ec34d3cedb	\N
0542fdb3-8634-46f9-9f45-23a49e087a83	\N	451d845a-b81f-4125-b1b3-f3ec34d3cedb	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	451d845a-b81f-4125-b1b3-f3ec34d3cedb	\N
48b10a52-fea6-4033-b02e-8094896a4899	rsa-generated	41afada5-8096-4d14-92f4-5079d0a42a1d	rsa-generated	org.keycloak.keys.KeyProvider	41afada5-8096-4d14-92f4-5079d0a42a1d	\N
c63c9a07-6895-4ac5-8374-f1645c386ec6	rsa-enc-generated	41afada5-8096-4d14-92f4-5079d0a42a1d	rsa-enc-generated	org.keycloak.keys.KeyProvider	41afada5-8096-4d14-92f4-5079d0a42a1d	\N
fded4b85-230b-4034-80c2-ab516c2b0c33	hmac-generated-hs512	41afada5-8096-4d14-92f4-5079d0a42a1d	hmac-generated	org.keycloak.keys.KeyProvider	41afada5-8096-4d14-92f4-5079d0a42a1d	\N
2118cfa5-b8a9-46b2-b87a-270fc2f6d9b5	aes-generated	41afada5-8096-4d14-92f4-5079d0a42a1d	aes-generated	org.keycloak.keys.KeyProvider	41afada5-8096-4d14-92f4-5079d0a42a1d	\N
5a58efb2-a6f7-4db2-9691-eb153f4d220b	Trusted Hosts	41afada5-8096-4d14-92f4-5079d0a42a1d	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	41afada5-8096-4d14-92f4-5079d0a42a1d	anonymous
8677bb12-a246-4572-8f6b-86ba5b0c69c7	Consent Required	41afada5-8096-4d14-92f4-5079d0a42a1d	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	41afada5-8096-4d14-92f4-5079d0a42a1d	anonymous
0d71fa75-e920-4d4e-b1ad-66ab8a1369cf	Full Scope Disabled	41afada5-8096-4d14-92f4-5079d0a42a1d	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	41afada5-8096-4d14-92f4-5079d0a42a1d	anonymous
4fdcdd11-c219-49bf-8f90-a68f8a782519	Max Clients Limit	41afada5-8096-4d14-92f4-5079d0a42a1d	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	41afada5-8096-4d14-92f4-5079d0a42a1d	anonymous
01f4d064-41e4-42d2-8d74-b9166a5f8141	Allowed Protocol Mapper Types	41afada5-8096-4d14-92f4-5079d0a42a1d	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	41afada5-8096-4d14-92f4-5079d0a42a1d	anonymous
5e6ebdfe-0a35-4e6b-abcb-9fb11324620f	Allowed Client Scopes	41afada5-8096-4d14-92f4-5079d0a42a1d	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	41afada5-8096-4d14-92f4-5079d0a42a1d	anonymous
52adbdce-81cf-4918-a85d-78c3f63098d0	Allowed Registration Web Origins	41afada5-8096-4d14-92f4-5079d0a42a1d	registration-web-origins	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	41afada5-8096-4d14-92f4-5079d0a42a1d	anonymous
63b5624b-f5a6-429c-8090-590a643840d7	Allowed Protocol Mapper Types	41afada5-8096-4d14-92f4-5079d0a42a1d	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	41afada5-8096-4d14-92f4-5079d0a42a1d	authenticated
58ea70b2-3970-4b82-b37e-584859c7d473	Allowed Client Scopes	41afada5-8096-4d14-92f4-5079d0a42a1d	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	41afada5-8096-4d14-92f4-5079d0a42a1d	authenticated
f657ccba-4e00-4fde-a3aa-f1473149f32e	Allowed Registration Web Origins	41afada5-8096-4d14-92f4-5079d0a42a1d	registration-web-origins	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	41afada5-8096-4d14-92f4-5079d0a42a1d	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
d288eea6-784f-4185-bb54-b1940e85148c	de842030-9c59-4aa7-a5e9-75b6340b3b31	allow-default-scopes	true
4c1dd519-c61e-4e63-bc9c-f052e2904337	5799d0b3-bd63-4d10-8179-6a21aa3aa6f5	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
54246111-e3d8-47f6-9d6a-96ff1850ccf0	5799d0b3-bd63-4d10-8179-6a21aa3aa6f5	allowed-protocol-mapper-types	saml-user-property-mapper
4194c8d1-df6d-456e-8844-e81d476c7895	5799d0b3-bd63-4d10-8179-6a21aa3aa6f5	allowed-protocol-mapper-types	saml-user-attribute-mapper
bb6d846d-e59d-409e-ace0-a04b2aa28aba	5799d0b3-bd63-4d10-8179-6a21aa3aa6f5	allowed-protocol-mapper-types	saml-role-list-mapper
0c6afc60-f418-4ab5-8768-0cf6a31cfb96	5799d0b3-bd63-4d10-8179-6a21aa3aa6f5	allowed-protocol-mapper-types	oidc-address-mapper
3330b465-72ef-4f51-84c9-b4e9484da5d0	5799d0b3-bd63-4d10-8179-6a21aa3aa6f5	allowed-protocol-mapper-types	oidc-full-name-mapper
20fff342-67d0-4dd1-8a22-a5f4d25210ba	5799d0b3-bd63-4d10-8179-6a21aa3aa6f5	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
7272dceb-1236-4fd2-8e8f-9327d8beb6b2	5799d0b3-bd63-4d10-8179-6a21aa3aa6f5	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d2f1bf51-bce7-47ce-b0b4-9d420004c7d8	e2f1126f-ae81-4817-a2fe-de6ee70b2a1d	max-clients	200
6d1d6290-7b3e-421d-8962-e4a4d9493fce	092acf98-bf1d-459d-b655-286304e23253	allowed-protocol-mapper-types	saml-user-property-mapper
5eaf837f-c15c-4603-8695-1db6f139466f	092acf98-bf1d-459d-b655-286304e23253	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
32d94f63-8f74-48a6-b187-c21b4913c059	092acf98-bf1d-459d-b655-286304e23253	allowed-protocol-mapper-types	oidc-address-mapper
7748015f-8280-4f17-b68b-9a18cf081dcd	092acf98-bf1d-459d-b655-286304e23253	allowed-protocol-mapper-types	saml-user-attribute-mapper
e8123c0a-5399-4e4b-85de-efefc6696ec8	092acf98-bf1d-459d-b655-286304e23253	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
ccbf0a22-2079-4009-b985-79675da928f1	092acf98-bf1d-459d-b655-286304e23253	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
3f3246dc-e27d-4fd5-b374-cdcac07b5d76	092acf98-bf1d-459d-b655-286304e23253	allowed-protocol-mapper-types	saml-role-list-mapper
adeec140-9018-4273-91aa-9487c8c02ef7	092acf98-bf1d-459d-b655-286304e23253	allowed-protocol-mapper-types	oidc-full-name-mapper
a04c9d10-a37b-4b0b-b6a5-722e0045f215	4e7f3e21-5117-4ef5-9f2d-01fccb2c126f	host-sending-registration-request-must-match	true
0192af05-0589-49e2-aed9-db90e86619eb	4e7f3e21-5117-4ef5-9f2d-01fccb2c126f	client-uris-must-match	true
091a7552-2677-4b20-817d-515110164239	d650dae2-a6a6-488a-97d5-6f81bd71433f	allow-default-scopes	true
1892fc0b-1f92-4db9-83ef-68f4c29354c9	c63c14d6-2dc2-47ad-98d0-5f19d2bd6b1d	kid	3c73cc7d-93db-4210-b179-3b1b609d5a66
9f4aebb9-ef69-4c48-9e11-308f6088f7a1	c63c14d6-2dc2-47ad-98d0-5f19d2bd6b1d	secret	Cb6O9PR4I5AIUEZKcm6k0w
23ebb1f5-8c98-4834-9275-4b77b1957921	c63c14d6-2dc2-47ad-98d0-5f19d2bd6b1d	priority	100
1201353b-5261-45cd-abcc-eec9f2c691fa	ef7f1b01-b21a-48ad-ac7c-3f22a7592452	keyUse	ENC
bf365584-9518-451d-9bb7-5df46af6a946	ef7f1b01-b21a-48ad-ac7c-3f22a7592452	algorithm	RSA-OAEP
6934018b-3280-40ad-b1b9-fae5195f113e	ef7f1b01-b21a-48ad-ac7c-3f22a7592452	priority	100
f5a3bde9-0498-4247-8161-aab46b22847f	ef7f1b01-b21a-48ad-ac7c-3f22a7592452	privateKey	MIIEogIBAAKCAQEAr3Fil70etK7wB48CjWHal7MtMVHt1ckb3YOmD85ujtc4Z/zVY4wuSIDpPAgAqmjmfRPJcjtBXmDa7nlClYHwmcubm8Hr/CgdIUoTbxnN6ft8sGgPxeaveQuzrJ0invcLX1GKKyMvPQZiUMk72o7CvYeiiVnjF9NGn6D/d7bHhV1a9d4Se93avu4ZrR1Byr2YK2c4YiDsBAPRkmtkRq9ZcEQiKpKJoXttHiDWsaICF9M+0o76OhrDmAaKWOhUNt0UyPMdBaiLklBgth9yQBAClpvCFZaMsw+g1ywOUHgV+gZcukQspHO8cFx733DYJD5E265Poidk3khd84UekadYFwIDAQABAoIBAFViafjublzCTQhotfXIG4I8DjEULhufUmP29+F2dsEnBok5eEMIDNh1gM2aGXTWM+LIuABTzWcY3UQ1mM25nTbEbJmcAfVJMpAqhJXMKbaIEjGqm46VzG2tX8cQ/LIACrVbslJ3P7zD+CJYJbyjQSzLr7OIHylPxm3XBa4mMyl4rJypXEXTaClPOqTo11zm4PJa17J30b24xILq78cgIITirKFoIr7m7ol4B5w0D/aKxuvLJtJauQJIMdW2o4ox/6+3BP1fTMs3SZEJuud2bm05/kVpha2m3JiRnpzys6OeSt40Jc+tANGLDtCabGyKwIODkor7frnJNqKzeP2ecNUCgYEA4jKUqr83cUspGL4SPhbQgK5BTfHv/CRgMdTWCpYFfFUv/3JZ286WmxEw/XLqTL2Rk+PVY78TZAnJTcF6OLEAZe52H/RY5meTADpN6J+VsIvo5rjcemqBJKysAHkvNNxQLaoSfP2gJF0OP94CBEKYdy7QhMWOG/UOIEtsPZ2Uds0CgYEAxo7mXs5nD6c7AFjDru+inBeO26nb/nLoc20mLodVVJqZ/yOGk39eHfqyYh008KY9HPXX91IebPafWSAc2BeOubL9Voppiljk0cZoX+i6ITaL5tUaAguFXHql8cCwOWG576sTZB5QcRmJ+HnM0oiG+GSDbtIZpXWClfIU+PFp4nMCgYBkfu54Mf5y8l6u5Ht8ZGx8T28qLyxdTNgEK7hw+Zg0VjC+AFMWCmH1QR0P7cdVEwAjwZyj9VerIYHzbttbZqBzqQ+IQOpia2/vMPg+OvCpgG+YWldyd/EqlyDQEQc9KAjjUOVn7NMCdOmIzJz+wYu1n/H6mz75AtYk2P2dHm7AnQKBgF/ktceFwWpi5nDVbbQ30X23NuxJjZDGqBLO3QjNnV1dyQ/adW0YrzilUa9m0aGDd7Jb3PB5/W28cdrWUnfecLSoiAdak3wYUHIrc08Wk4Xk1Q4nTwc7zy2JokkuOS2NUAI6ygOpTEpC/ko9cLkg7KZbzMoht/cb2HRYVN6hoPSXAoGAcT2qsdPEXFKrdRZhMaJ3GwPFTkSt0MEVuH+aEv8aGGxZLXpyFBE1u8IIQRFuspMLc/XybAonNzge2A6aveALrwNuQpYfk4AJej7EY5Fo9TI7GNa6zqYtWvoT7cJVeCkkiAHH2yAxO1kPwfJUaplgepxHcgtGLql5vguNkZ1p38s=
2e377c13-62c9-48df-8ebc-7417a6492464	ef7f1b01-b21a-48ad-ac7c-3f22a7592452	certificate	MIICmzCCAYMCBgGcvBqkXDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwMzA1MDM0NDQ4WhcNMzYwMzA1MDM0NjI4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvcWKXvR60rvAHjwKNYdqXsy0xUe3VyRvdg6YPzm6O1zhn/NVjjC5IgOk8CACqaOZ9E8lyO0FeYNrueUKVgfCZy5ubwev8KB0hShNvGc3p+3ywaA/F5q95C7OsnSKe9wtfUYorIy89BmJQyTvajsK9h6KJWeMX00afoP93tseFXVr13hJ73dq+7hmtHUHKvZgrZzhiIOwEA9GSa2RGr1lwRCIqkomhe20eINaxogIX0z7Sjvo6GsOYBopY6FQ23RTI8x0FqIuSUGC2H3JAEAKWm8IVloyzD6DXLA5QeBX6Bly6RCykc7xwXHvfcNgkPkTbrk+iJ2TeSF3zhR6Rp1gXAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFC2LZJBi0B6V8C9Xw6exEe5vDNbWsZJHO1Rzp6JHzDd04dH4oTcInmarDhK62pH2o4zzYdnI7+TQS6b8ogWZBam4sJyJ2ftcYVAFZsL2YoBDUxsm7EL7zGwkDE8v8loIf+40usDyIKkjSIcDdCJ4h5za+RQDKcaWm+WK8/AGHnneYEQ9f1J8P7BYRd1pMuraBr/A8Lk7ngS+ajUNOzOpnCeFRNKQbJ1HtMS/f9XSBk5LqKHVmaaddITrCIpY0imIPCiajR5Bmh0Rx4IAKY7+M/xJYFrXj7m/EUCzIEQoegnZNygVAMMaHT2Max7uz/oLgTwVj2A1zO9G5tYhT9PFpU=
59c91894-978e-440c-a4a9-e48e14bcfa0d	0542fdb3-8634-46f9-9f45-23a49e087a83	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
537878e6-6367-4af8-a5f4-ec689ca5c2c0	36fd086d-94d3-471c-b34c-bc65d12ced97	priority	100
c9f1532c-7f1e-4c41-aac7-1e2559b14b77	36fd086d-94d3-471c-b34c-bc65d12ced97	keyUse	SIG
ce17bdb9-99ac-4617-8149-e3ff7c8d4a40	36fd086d-94d3-471c-b34c-bc65d12ced97	certificate	MIICmzCCAYMCBgGcvBqkLDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwMzA1MDM0NDQ4WhcNMzYwMzA1MDM0NjI4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC2W1AFxDLKe7OW25EHlqKrFsr/4ytIivRO+Fg5xwY9hp7kTdouQPx32BeVb3Bs2y8XtzW729wBU8s/KQthCJV8YgPV9nqJdD6yomwl76OHodtXzC3A99mf1s4jtcyg7yXD1pLvmRscKp8GF2EKC4cYEIUcwL89bXRLLFlXd03kL5mfbrgr9VYgnR0/8ju4JYOLu8bed+rFQzIm3MCAz4PmMhtbFc09s11KapUMZ8sgl6n2K8am65QXSoK+NpIOASsruOWM7EAa/G2KdaA5xQ2EWgwl0OofAW70wd8cAUSCRf9ecNqVchF2KEKl412Pm0hw9TguEXLAge3GEetBT5IjAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGrHKznKLxE8PO9hzyZh+W1byIz+AeZjdI9h9xiC4E/4jkXkhkirVaiNQkhfrBJ6kwdyKZBlPthjEcVq06dc+VgdeRbGDFOu6kXLObtrTOIJGzIYg+DyPn9hXYwfddicnfLE9IgTJC2HpUquq5064NoAbOYrwyxCAdMf1tbFoFWWVBo8Pia9HapieqAa9aCBzops3Ai30Y7JwoON3espZf8GlIZ4OG5ZcbbVTf8eTh9l2kIIQaIVWFWu6+1FcUCbwUzkNb70tCN0GhMHJSWucEZIKcNVdbo9R1o5VebSiT1J03yQ7R2zvPzYqItokvmhOO/dk8ako7R3+SLif8Lu7lk=
a005de18-b7e6-4355-b147-7bbd2d404442	36fd086d-94d3-471c-b34c-bc65d12ced97	privateKey	MIIEogIBAAKCAQEAtltQBcQyynuzltuRB5aiqxbK/+MrSIr0TvhYOccGPYae5E3aLkD8d9gXlW9wbNsvF7c1u9vcAVPLPykLYQiVfGID1fZ6iXQ+sqJsJe+jh6HbV8wtwPfZn9bOI7XMoO8lw9aS75kbHCqfBhdhCguHGBCFHMC/PW10SyxZV3dN5C+Zn264K/VWIJ0dP/I7uCWDi7vG3nfqxUMyJtzAgM+D5jIbWxXNPbNdSmqVDGfLIJep9ivGpuuUF0qCvjaSDgErK7jljOxAGvxtinWgOcUNhFoMJdDqHwFu9MHfHAFEgkX/XnDalXIRdihCpeNdj5tIcPU4LhFywIHtxhHrQU+SIwIDAQABAoIBADga3QKBLE1PBOCXukXW60JvV1KmToVZtzPqxZ41JS7d0doVN9j+Ro8Kzaq86B6dyx3lUON1D/nakZBjrOwUS4XC1EJKvMW4naexQEvlsG8E9erL15Hkz7CVUsP65bPoEDryNDACb6xZUqb5n3ILPOvC/Wlsxgn8uIh+Yxh9jNn05BOSXyYCAEY+YLYzCBojxBoKJ3ywtRZDyjyZipBVa54QG1kJpphmPGxXkxsMmcyutYpXNQnCohBsE5CbGj1Iz1wNqfRx1doyLxxGi5f9htviiruQZqMYRF2CGJh4f6/HmPA04hcieN0ObMvuLPxerGsQ9tq+JYqsoeVEDRQQqvkCgYEA41dgAUC+vDCq2/OFVLReSJepLZpzWtns6rkBNd/rGupdiyWGHrpZ8/f0jmJ5B+Pgz8a+q5m/sRHVcv9070clTfauBDNLVK/Fi9aUm2Yq92zfqcjdGm4myKwDlBDOTkImfjGKjDgA7lQzkDA2p8tLr1muePH9M217auWHjZb3pGsCgYEAzVg4bNTkNkgZumgc3JbIcJDMOShJbeMwCBuyZ1qJUL8yXTGrfbVN/LE+ntUnf2DxWoSVNuuH2QDYxXayakE0ifdbkIfw0CWeoZS6Eyw+y86sRCHPzwL7Ed/q5mMp3pMqVOmcq7HR9WNJcJf0a1WxdOw3+dm3F3eDGsadkiTJ9ykCgYBeth0KCJYtwry7y5VFd6s75OsXU5wxQk8AbrjBYBsLaI42FRjuHkaxbCCXXRD9J4OWLD9tMC17MGnTcfeeY+53r4hJubDthBjxrCDXKNZHpDT9/++VPkSsH3WSLvo0Aj0VH8CPsBk7MRsWO+/ZMcnDMMKOIoqQ7VCYdS1m4HklJwKBgA942DeLCu70G8wp0BLm4Y9puZmM6Yt4FMRnodebwMDuxxKyjWNZZ9jkWf2JvgIhAc56MuwCbyfwomSuft72rsi+dI29UG2+h+dQ13xeVxTwK5aunYPRi61bG83kJuF4YTYoq/9b1KASrRPovyffOxG+QrF2sA76mExKLtE2KGmRAoGAQBB1O7/8y+XJffpQ9Pryiwwx4xHSFp6xXNnt4SneKRLLPPHaatkZ7ZL9IJYDSSqtaAWhK0ROkoFffrmrOdm3jOFYPcOs8HmcbpZ38Lpfiav0LnoTrHKGus7JZh+xrPIQzEQAQdrtd79OAUVT3tQ9TlTJlftVX1z7WDp6Hsi8uJs=
34154439-095f-44ec-b4a5-38b684534d9a	4d26cb02-f575-47be-b952-d83b49adb9cc	kid	92319341-dbc8-4813-8d86-06318b98e39a
097bd0d4-b997-45c5-a738-1fa066cf591f	4d26cb02-f575-47be-b952-d83b49adb9cc	secret	_FwkmTdjLEU_p9NzpTQzggPz47hyMFZrRG4GbAWjJcqN-th8mjfgvOq-wjCI0AgQiOnLsCQT39N1cTjkVdj7P1Scg1Ri4LUKALaSejIPE5kc8NM7mqlG_bXzfYanVDKMZe578NShYLA8adpVT9Zz-sE5SCRPRL8l9PI1xqJdDVI
3e7c7893-9c77-46d6-b138-ebeed6001b9a	4d26cb02-f575-47be-b952-d83b49adb9cc	algorithm	HS512
6582f46c-63fd-4499-a24e-000d4da94e9d	4d26cb02-f575-47be-b952-d83b49adb9cc	priority	100
fada114f-ce78-4890-aea5-0c38d11f40a7	48b10a52-fea6-4033-b02e-8094896a4899	certificate	MIICtTCCAZ0CBgGcvCZ2GzANBgkqhkiG9w0BAQsFADAeMRwwGgYDVQQDDBNzdG9jay1jb250cm9sLXJlYWxtMB4XDTI2MDMwNTAzNTc0M1oXDTM2MDMwNTAzNTkyM1owHjEcMBoGA1UEAwwTc3RvY2stY29udHJvbC1yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANMrehqE59vWuyiSYhmPgHXGeXZzan00RB1EEIbjlXJtgSm3ft0c+kHQ3uTLWNDNtP3jEQIpZJCdiol/7m485oxixhux32YHTtp3RrsktkVUplIbWUVkfu+WL0lRtspBDijX+QCUYn6pvGMsif+rW/q7exQI7dS2c79i6UEjYuqGKPjKTxMK5YjspSzB2El8tcE1MbHv7cnB6qE8KBL8azROrBzCx9FXQ6GNXQx+ySJiEz8p5vFUbA/LOpUSte33NebNqkb39/Di8/6QrUYwSJyi21ynyuMkx/LhSfD+C1DvdfKlj+IkpMPMzOn+hhfNRGv0gCpBEAmbWLjziZ9A/rsCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAblzxuc3ycodmpd7RS49lAXp0gNe7vy+2AvXvRDFc5ZfRpNk2ech4dWl46PBF6kR7uGqaiOaR1IDzVDlG8sexeNeTUIjpPdopaGCVCz77BBr/Sz1mrq7ED0Sp+vbV4HABapY3sNCksO3fOVxeP1B/XRmLazvyZMaFmeZCqWPdpUvQjwT4uAnH0RhmmDUdajAfkKdkklUAWpDsFzann9jsvi85RYUpX+32jet1bivUdSnIpw10kJweQQw624hA8EFj87n4V5wH7fPRWdrvzrPU+M1PGYwn05X8Ey67mzN5BCtVRN3x0IkFCFop1RumyzwbCTWMgDO02e4mkB0TCqsV9g==
9edd653d-1423-4fc5-ac38-82fcf4da41c4	48b10a52-fea6-4033-b02e-8094896a4899	privateKey	MIIEogIBAAKCAQEA0yt6GoTn29a7KJJiGY+AdcZ5dnNqfTREHUQQhuOVcm2BKbd+3Rz6QdDe5MtY0M20/eMRAilkkJ2KiX/ubjzmjGLGG7HfZgdO2ndGuyS2RVSmUhtZRWR+75YvSVG2ykEOKNf5AJRifqm8YyyJ/6tb+rt7FAjt1LZzv2LpQSNi6oYo+MpPEwrliOylLMHYSXy1wTUxse/tycHqoTwoEvxrNE6sHMLH0VdDoY1dDH7JImITPynm8VRsD8s6lRK17fc15s2qRvf38OLz/pCtRjBInKLbXKfK4yTH8uFJ8P4LUO918qWP4iSkw8zM6f6GF81Ea/SAKkEQCZtYuPOJn0D+uwIDAQABAoIBAEgahM9QSUD50Z8ZWJDEvIa6ddfZsec9dPKPPptoUyums180rgc+8T6O3MS/oDxvuNil8zVLP/DXMiof+iA/ADO4OE/VjOOwJB8ZchfNgcUrkbzgZLt6hJM3Mz80PRdTXkvY7sdhYz4/o7kzSI15i+cRpAVjxR2IDP6w/ddFh21vMV8L1+0puCHL8rwvVDJ9jL5tcMKUouT7JYe7iQj1IHimxBGQm2oX4ex8jCmBQvkVS1Ib8/AzuHnvz8vBriqeeOXZCrX1cZrqKGwj9ot2TRzCyqJaMRl4JbdEVOVj+R5GITY4fTSCP4hK3hnRRiDQQJqceYQyzECvAOGJLZyaF7UCgYEA/hjJh5TLZ5ljhNFmGW+YT0fFhxvnj0Z/7t+3irwuS99nz1zwI5DvyIwW13eYPrtLkKK0ECVBoNnqUZRyUviCAqFRcLRh3wONCzhaAFL3iuA/KZHd8P5AjwTdOokX8TQUGGvWPuhWxh1RHdoITCf4L6pOGi8R9lr0qzibLFHNrz8CgYEA1MBhWFvM4cu6MrvaxYdKx8uUV07RyffHsGPi1m5ItwSZ7luFIqruQYfHM34s/SGRv9bpAXAvXQGsm/hSQHau5G8t423OBAKz3k2elWPfqwCIg/qQbaV59ZDgRKDSA133FbOuYZeu7IPlL3DMM62Z+hjREAevM3OAxqy810GRTYUCgYABGuB9e3Mq/yrEoBh+kdKqvZgpT0DBib/yrPxiWREmeVE9QJ02umGgkKNkyntaAnyAo4R+8XqIlYoEUs3weG4wTr1I7S/jxWMuok8Z40J6UyFTL/Q0IRbsyEuh/oihHuXbeVSUL3R5JhV9OL6CfkYBBw+R45SDar/XosZh+fUYBwKBgBgBmTpiKW01Es6UueveB0ciJpvvbeavSd4Sd08g5J2aLFBkDVLLHNVSH90kmKj7d7nA40vhP8br4HE9BPL3MWbfULs/8aYsM+WatpE+0sc16TGTPWbR7EAUV+oGh4wPt0jAnKWwevF/NIY04SXXqe85i6WWaGOS3e4NIcXcRSwNAoGANwrRppXBr9Crz8XzTeoKMSzZNPHUokJfAkTundQEQLXEmpnLkVD9m2Jw0iQ66X+LlQwxJpBkTHVBm8xYmWfiQdp/1ZVXuf62X7MXetp1eEppCA0gwGlWxxJWiEmMgoPFFrldBK8DY7Is9D5JSEUiG2nJ+yna21iag2xOn/o5a3o=
662a2a45-b0f2-40a1-9b46-a8975aa0fd3a	48b10a52-fea6-4033-b02e-8094896a4899	priority	100
dc903453-4baa-4087-9d03-c65a88ee2da7	48b10a52-fea6-4033-b02e-8094896a4899	keyUse	SIG
cc3493b1-2a72-4904-8855-b4b450342f47	fded4b85-230b-4034-80c2-ab516c2b0c33	secret	LiX_tcDtT0Uz4wGnw2FTbp0AanlCNrvJrxkcY8_iitJf7wVpdt39uBZcsu-HRmhlOVSpFE6oYhWKwwArVGl9jk4RP7fw5uSavc7_omfXGC7BL1h1YK1dZg2SmYEgNagm-_6138ggl5K5pp8TNogUB2GQ2z0n84Ahy9g56qFO4Fw
7805194b-09b7-4565-8e9d-8cc0582bf23b	fded4b85-230b-4034-80c2-ab516c2b0c33	algorithm	HS512
1f82c7ff-9bdf-4d31-9188-a02c186a0572	fded4b85-230b-4034-80c2-ab516c2b0c33	kid	f33fa882-35bd-4b8f-a424-64201cc5851e
b8bb87bb-0e05-44e0-b1f1-26e66b68f73a	fded4b85-230b-4034-80c2-ab516c2b0c33	priority	100
32988d76-cdfa-4fbe-ae8e-2894cabd3108	c63c9a07-6895-4ac5-8374-f1645c386ec6	priority	100
7add678f-6c65-49c7-93ed-91c912a13361	c63c9a07-6895-4ac5-8374-f1645c386ec6	certificate	MIICtTCCAZ0CBgGcvCZ2YTANBgkqhkiG9w0BAQsFADAeMRwwGgYDVQQDDBNzdG9jay1jb250cm9sLXJlYWxtMB4XDTI2MDMwNTAzNTc0M1oXDTM2MDMwNTAzNTkyM1owHjEcMBoGA1UEAwwTc3RvY2stY29udHJvbC1yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ/5EQOdWguyNfZDvr2o53H/F1sme25WDYTtaLsaotxGQH8nu+rXGbHU7oiwdGLMWFg2tixeBjVr3mIBGB1kVfYU6lCe56ukOgHBPdML5P+eNCbqTIH29WRUec0tbvcH+JXjOakGAqj3+2023hapHeyZltl2KAa3UV6NoSUHdl/Ymxrm6h1FgxqZ47Q90n1fW2QdZnheXetQ6kv2lJqNBIjWeZ+5j4Cq9+LXpvTuEWK8GUn+QiqJr+cRe/we/mMNswQxy+CCHT/uY0lGOkZuib9grEsNZ4/gfp5VQ4sQUX1hWcS8YvwcYk4lMMkOH7hwlRbGl4KewBFPtuZrErYOo+UCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAEbigw4jSOKX0/RtScoE7DxTt7DlFy5jcNZQZ2FglTamNthGg/llQQUvrT6oOB46l0dVvUEyvKUukm7KPKPFP7vYZTARC1xhCFL4BGu++IZ0iar/EvTM552dHF+yHFRS1vZRRrQ8zPNdfB4Kti6bBtKJ+KKxI88zC9Cc7krVZtQiq1tbN5+mtzaXs9ilf1WwmmEoRR8FMnF0bZCTzrqMuH83i1GRfUdUBuAa0A4AuCV2sOYB2/UVAYCe1H11JcgftqD6n80aYe85PAZUqJySr7TUi6QoEXDtUh0/6WrsuP8sXaCDy1Q2g9P5lbnVCM3COB5C2YbrRasScFAaM6CoyCg==
08be8dae-c07d-4e99-ad4c-acb135626cce	c63c9a07-6895-4ac5-8374-f1645c386ec6	algorithm	RSA-OAEP
32f8e611-3b93-497e-9568-27412302258c	c63c9a07-6895-4ac5-8374-f1645c386ec6	keyUse	ENC
bd3d249b-4b45-43a2-a154-b3edc4134791	c63c9a07-6895-4ac5-8374-f1645c386ec6	privateKey	MIIEowIBAAKCAQEAn/kRA51aC7I19kO+vajncf8XWyZ7blYNhO1ouxqi3EZAfye76tcZsdTuiLB0YsxYWDa2LF4GNWveYgEYHWRV9hTqUJ7nq6Q6AcE90wvk/540JupMgfb1ZFR5zS1u9wf4leM5qQYCqPf7bTbeFqkd7JmW2XYoBrdRXo2hJQd2X9ibGubqHUWDGpnjtD3SfV9bZB1meF5d61DqS/aUmo0EiNZ5n7mPgKr34tem9O4RYrwZSf5CKomv5xF7/B7+Yw2zBDHL4IIdP+5jSUY6Rm6Jv2CsSw1nj+B+nlVDixBRfWFZxLxi/BxiTiUwyQ4fuHCVFsaXgp7AEU+25msStg6j5QIDAQABAoIBABbOtstHeDAUtLbV9RrV5Zw4x0av7Nx6mQDWVvPeGfwXvq2iUkYVbCIQ1AAEUFj0U2Ai+hlx6lFcKLTbp77WWvRztO3Q9Ky3BFd9tT0irqp3DsPBly4sXH4fwSHXPsEqOhnR70WW3XLjsCK5C4mQNlD7m33ePQSqxtzD39wHUqwwBu8YMVw1ZtUMNwRtxZUuVkkEAmGeDTaLJT+EyJW6nScnC7PYmSeiay85eRQoUcHai0LTEgrOpupoCxJELXb8OIrymaks0KSpAov2TwiZp2ABmiYjKGc3oOKNzVDsxuG2xyAmV5XbFyPbvfHFICsNGbQr+lYj26ep80SUdb7EfB0CgYEAzWVSWa9uo1PkPkQcDGulMEsXaxVRAbM/UjEb7t+hLXqV2DPSJHcYbzVWnd4qEBoXh6jB7CBnd5rE3Av6JUifBbBwiQUxW61vYp//xeG/6Sa5CnoNs/B1EgdLiUWDCNBnamnUJimo51omrTY9lWhkgEZXBH6cqC/Mvuo7i5W46WcCgYEAx2LX4zApzraLFftBv0RCymP8axKGqn9sE/aYohAiKjTjPjl9+wSUT4Q7wVyAY3S+6efurMR6OwufUVxOLAYs5c7/VojoIuoPrYkmccr+56Pe1dWjlUYCWWD7EGH4bz+C6+L7Pa8rydDWG2HaH0pSnsZvYLDlFYwA3Y8FMEuJHNMCgYBehDenCbGx+xLXDGST2p1DYeq+3ipOy/thiTO/cq0qznRR71bObPeThUn8j5Vvn3IgfSnvzOGQCmp4kBJmQcrbxVuj0f3qoB7XlaUPnFjBo44XIh9YJFjbGPxLiO9JiQ1tzJFRlm4hOD0ADCu+qzFEThoQ+WqBgq2HVSZdj2JuFQKBgBJavgby+xZFZZ5bZ90EmqVo+OaeaPkvC7L2w2w/0fVSswyaXEeMT17WjG2rZ0JAkAaWTDlpSNtAoaTqu2OAGgf5uzWrGruEEndmJbzZ9Ac85ZmHtixaqoKx08rZSfZrwVCXr4spIf3NFLimlF7HB74IBF7BSgVmwvmiXdbpTTDzAoGBAKfgC/94ODFwUYHPpsZqzmbZowoJxTTS/FJp5XdjsBpqgoL07eWQkB6e3YkvZ9Cbqrb0VwRTlUcGsHVVrrFERR9HI5yzvc9jpfKI+SlHVJhjojNte2YAlljVoNqCzuXbFTlVrkfBxYkcZ7A4eO5OtGxPzrd/is4QZlVFLX5ohM8I
7d9b9fc2-596a-4469-84b0-8fef07c721f6	2118cfa5-b8a9-46b2-b87a-270fc2f6d9b5	priority	100
656b8e9d-f38e-4e1a-bf83-733db8b0c6c1	2118cfa5-b8a9-46b2-b87a-270fc2f6d9b5	kid	b590d2a5-381c-43dc-89c5-6987e681a282
e7d3bf87-9e82-4b5d-8191-c34b6a264bee	2118cfa5-b8a9-46b2-b87a-270fc2f6d9b5	secret	tYaED6DbxMLCD54YYQyWMw
83e7d6b2-c267-46c4-a5b7-6d50c4c8b4ea	4fdcdd11-c219-49bf-8f90-a68f8a782519	max-clients	200
031d5d26-592a-46d8-9083-5644b5027846	5a58efb2-a6f7-4db2-9691-eb153f4d220b	host-sending-registration-request-must-match	true
00fd03c9-feec-4f26-8108-7c3009d18d86	5a58efb2-a6f7-4db2-9691-eb153f4d220b	client-uris-must-match	true
624c2e63-88b7-4e52-b38a-570129023dc0	01f4d064-41e4-42d2-8d74-b9166a5f8141	allowed-protocol-mapper-types	saml-user-property-mapper
e294eac9-c533-4924-ba2e-84d8ce9e565f	01f4d064-41e4-42d2-8d74-b9166a5f8141	allowed-protocol-mapper-types	oidc-full-name-mapper
dfaa64d4-85fb-48a3-86cf-daa3ec60ac0b	01f4d064-41e4-42d2-8d74-b9166a5f8141	allowed-protocol-mapper-types	saml-user-attribute-mapper
e5895f99-fb5e-4e8b-a183-6076de382d66	01f4d064-41e4-42d2-8d74-b9166a5f8141	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b06633f5-3f3a-4eb0-86d1-102142ab4ef2	01f4d064-41e4-42d2-8d74-b9166a5f8141	allowed-protocol-mapper-types	saml-role-list-mapper
c09b3124-ce75-46e0-ac14-6a9e53b4a532	01f4d064-41e4-42d2-8d74-b9166a5f8141	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
2a738e43-b695-4782-8997-6a57d1e49d7d	01f4d064-41e4-42d2-8d74-b9166a5f8141	allowed-protocol-mapper-types	oidc-address-mapper
eed78ff5-cf44-448c-931e-142bef2b8462	01f4d064-41e4-42d2-8d74-b9166a5f8141	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d7203cca-6393-416a-9be0-e75f0ae17b08	5e6ebdfe-0a35-4e6b-abcb-9fb11324620f	allow-default-scopes	true
e1176377-6158-4280-848d-09e25fe770db	63b5624b-f5a6-429c-8090-590a643840d7	allowed-protocol-mapper-types	oidc-full-name-mapper
5f36760d-b325-4693-8942-152ab5486a4e	63b5624b-f5a6-429c-8090-590a643840d7	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
889c9672-f594-4403-bdce-60fceed270cf	63b5624b-f5a6-429c-8090-590a643840d7	allowed-protocol-mapper-types	saml-role-list-mapper
067f0106-6bbd-4fff-b968-8ffb16a0e51b	63b5624b-f5a6-429c-8090-590a643840d7	allowed-protocol-mapper-types	saml-user-property-mapper
55a65dcb-93f9-4d19-a8ae-9eb3f5b1bfb7	63b5624b-f5a6-429c-8090-590a643840d7	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
f3c78dc1-8660-4503-867c-706cd980fc9f	63b5624b-f5a6-429c-8090-590a643840d7	allowed-protocol-mapper-types	saml-user-attribute-mapper
a6b381fa-51b9-47fc-a385-cd3219bce2e3	63b5624b-f5a6-429c-8090-590a643840d7	allowed-protocol-mapper-types	oidc-address-mapper
5720456f-abd7-4c95-93d6-a6a54ea42d5a	63b5624b-f5a6-429c-8090-590a643840d7	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
bc78c7ba-a96c-440f-ae59-dd004711ad88	58ea70b2-3970-4b82-b37e-584859c7d473	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.composite_role (composite, child_role) FROM stdin;
51ab19a8-a21d-4a78-aca0-5ca7146addb4	7cafcf4b-1ffb-440b-9d63-61bf66e800e2
51ab19a8-a21d-4a78-aca0-5ca7146addb4	01edd8e7-cb34-4f3a-a4f2-afba4953853f
51ab19a8-a21d-4a78-aca0-5ca7146addb4	6075d2f9-10b7-43b8-93b7-1cca8e7f46ba
51ab19a8-a21d-4a78-aca0-5ca7146addb4	76a09dfb-10af-401b-978a-3fc709496b4e
51ab19a8-a21d-4a78-aca0-5ca7146addb4	685e1786-28fb-4c56-bcb3-926929a0b9c5
51ab19a8-a21d-4a78-aca0-5ca7146addb4	18924356-32d5-4818-af50-67da6e0a8e03
51ab19a8-a21d-4a78-aca0-5ca7146addb4	88d223a5-6b10-41f5-840d-d12597ea372e
51ab19a8-a21d-4a78-aca0-5ca7146addb4	4a893a6c-5dd3-48d3-ad4c-6c7a066f370a
51ab19a8-a21d-4a78-aca0-5ca7146addb4	5ab1b3bf-d645-401d-a3c6-ddc27292bb4f
51ab19a8-a21d-4a78-aca0-5ca7146addb4	5ded7de1-d49f-455f-a15f-0b14b2950eeb
51ab19a8-a21d-4a78-aca0-5ca7146addb4	97c5b14f-c87f-4938-81e8-fc358d452ba8
51ab19a8-a21d-4a78-aca0-5ca7146addb4	4badaf1e-4182-4b71-b513-fa84461083f6
51ab19a8-a21d-4a78-aca0-5ca7146addb4	85b5a70c-2cb5-4f66-87c5-6f80c56089ba
51ab19a8-a21d-4a78-aca0-5ca7146addb4	28037756-235d-4ea9-b876-8d63eceada5f
51ab19a8-a21d-4a78-aca0-5ca7146addb4	d34a3077-a382-4d98-9752-ad9f6f6a3627
51ab19a8-a21d-4a78-aca0-5ca7146addb4	934bb228-9b82-4c04-b574-a9d0cc487caf
51ab19a8-a21d-4a78-aca0-5ca7146addb4	2e64f935-491e-45c0-9592-376b25af1f6d
51ab19a8-a21d-4a78-aca0-5ca7146addb4	019df245-38fd-468e-90f4-f123e008e21f
685e1786-28fb-4c56-bcb3-926929a0b9c5	934bb228-9b82-4c04-b574-a9d0cc487caf
76a09dfb-10af-401b-978a-3fc709496b4e	d34a3077-a382-4d98-9752-ad9f6f6a3627
76a09dfb-10af-401b-978a-3fc709496b4e	019df245-38fd-468e-90f4-f123e008e21f
0188e131-5704-4cc9-92db-d30de3bab1b4	bdb894a6-41f0-4d71-84a4-9bf45f2cc569
0188e131-5704-4cc9-92db-d30de3bab1b4	ba47cbd3-5ce9-4eae-9c4c-08b4994b64af
ba47cbd3-5ce9-4eae-9c4c-08b4994b64af	0af35204-99bc-4ed0-bed4-bd272fda8987
faa7a960-f067-4d4a-bbf0-f21c6835688b	f39b4ce8-b27d-4cc7-a2c5-1e84d5a3c6c7
51ab19a8-a21d-4a78-aca0-5ca7146addb4	a4e387fb-ff53-4dd6-8256-a8877e4d46df
0188e131-5704-4cc9-92db-d30de3bab1b4	8478cda7-e6fe-41bb-bc75-780473d6af86
0188e131-5704-4cc9-92db-d30de3bab1b4	4c1aa771-3cdd-4760-a457-782dc86faee6
51ab19a8-a21d-4a78-aca0-5ca7146addb4	61dadc45-58dc-4d35-a057-95eac4a9d0a8
51ab19a8-a21d-4a78-aca0-5ca7146addb4	dd5ea0b2-5ceb-4a5a-a0bf-66c9dbb84a6a
51ab19a8-a21d-4a78-aca0-5ca7146addb4	9499d3c3-c5fe-458e-ae30-ba6c126ae448
51ab19a8-a21d-4a78-aca0-5ca7146addb4	11ead119-7862-4d2e-ab1e-2153e5f19e34
51ab19a8-a21d-4a78-aca0-5ca7146addb4	4edd8846-473d-47c2-8f9f-50116dfd0ec1
51ab19a8-a21d-4a78-aca0-5ca7146addb4	b58b118f-5e71-4e39-b9c2-f21a8fa2b5d8
51ab19a8-a21d-4a78-aca0-5ca7146addb4	3e1d0e26-aa1e-4d1f-8534-242013e6eb98
51ab19a8-a21d-4a78-aca0-5ca7146addb4	6117e325-c852-4bbf-98cf-b920c4af3a4b
51ab19a8-a21d-4a78-aca0-5ca7146addb4	b52fa1a7-d064-48c1-b42b-35c8546369d6
51ab19a8-a21d-4a78-aca0-5ca7146addb4	a7a0241b-7b2d-4f24-bc34-7cb0c5b32823
51ab19a8-a21d-4a78-aca0-5ca7146addb4	1d0fe254-4bbe-4c46-be0f-da5a3485bff6
51ab19a8-a21d-4a78-aca0-5ca7146addb4	12a7b9dc-fe26-47c0-8703-a9043fae4558
51ab19a8-a21d-4a78-aca0-5ca7146addb4	415725b9-6a1b-42be-ab64-5e57e14de935
51ab19a8-a21d-4a78-aca0-5ca7146addb4	9c7daa14-116c-42f8-bd89-7633e9775b26
51ab19a8-a21d-4a78-aca0-5ca7146addb4	009e7f02-bc5c-4574-abc7-1488a0356dc8
51ab19a8-a21d-4a78-aca0-5ca7146addb4	e8b807df-f473-4917-95bb-c39390c21900
51ab19a8-a21d-4a78-aca0-5ca7146addb4	c5569887-bd79-46f5-9df1-c74a51656c32
11ead119-7862-4d2e-ab1e-2153e5f19e34	009e7f02-bc5c-4574-abc7-1488a0356dc8
9499d3c3-c5fe-458e-ae30-ba6c126ae448	9c7daa14-116c-42f8-bd89-7633e9775b26
9499d3c3-c5fe-458e-ae30-ba6c126ae448	c5569887-bd79-46f5-9df1-c74a51656c32
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	6e1d05b3-a718-4353-be4b-47da366900b4
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	bf678d1c-d841-491d-afad-c3f9ea62d093
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	11cfbd5c-5148-484c-a0b9-81e5c8b01ab9
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	0dbd69b1-0072-4662-8781-186a48b0d373
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	8c0ee46c-c45d-44b7-98f5-68f197cdd587
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	497af44b-ea80-4d8e-b140-f7bf93bf65a8
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	a9fb01af-a633-40a2-b657-c0c652853b13
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	2354ef61-7727-41b2-87a2-4a9e5407b270
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	be41ca3a-78ac-4f0d-8984-1250f2854e12
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	3ed960bf-da8c-4179-950d-49111a8a2b4f
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	cff43f60-10e4-4253-915d-d8ecb03c806f
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	2ccb3e97-30ff-4087-8d72-c8d3bfef9400
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	19af6633-3e12-4f4b-af6f-6941df6255f5
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	7060a8c8-3c99-48ea-9016-4087b4424948
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	22bdbb88-03d1-46d3-814c-587ada59eacc
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	0c3e941e-5d2e-4583-9496-afe1ca154198
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	73b434c4-d70e-4481-80ca-d24696e60946
0dbd69b1-0072-4662-8781-186a48b0d373	22bdbb88-03d1-46d3-814c-587ada59eacc
11cfbd5c-5148-484c-a0b9-81e5c8b01ab9	7060a8c8-3c99-48ea-9016-4087b4424948
11cfbd5c-5148-484c-a0b9-81e5c8b01ab9	73b434c4-d70e-4481-80ca-d24696e60946
0c352c65-a053-46af-9cb1-2be7e5b9b943	5611748f-92d7-492f-9b65-b519858e0880
0c352c65-a053-46af-9cb1-2be7e5b9b943	28d741ec-c313-43ef-ba5f-8602959e9787
28d741ec-c313-43ef-ba5f-8602959e9787	6f76ae52-e706-4435-8c97-d29958821459
5135eec8-b038-4d55-9055-3e5035979d7d	d19d84fc-70fe-4499-b018-80e724ff4036
51ab19a8-a21d-4a78-aca0-5ca7146addb4	bcef028c-4553-4a69-916d-2f9d5a7094db
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	8e3227c1-507c-47d6-a0af-679a630493e0
0c352c65-a053-46af-9cb1-2be7e5b9b943	c2dca058-7202-4620-b0e0-db3442247fc4
0c352c65-a053-46af-9cb1-2be7e5b9b943	e569af44-2819-4a4a-ae6b-6e6880c78f40
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority, version) FROM stdin;
6db8617f-ea5c-400f-8ce6-e5c393624a45	\N	password	949b1377-a910-4a0c-975b-c730c862f502	1772682388755	\N	{"value":"9yC7Ldz6e45gnaX1p0GbsSzy897Ja/ekqFT2OxPcm0s=","salt":"y+7GThCdNumoWjNydG4+PA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
78319796-e6af-49b1-8969-e218ac49f7ad	\N	password	753f9009-b472-4566-9405-a4e932dcfe6c	1772683449780	My password	{"value":"uD8h8URfAyddL2DCAJs/zLOSZq9af5YHLx6Q0xiPgFs=","salt":"sHkVPRN1CzSMHYczvKcwgQ==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	1
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2026-03-05 03:46:22.025036	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.33.0	\N	\N	2682377906
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2026-03-05 03:46:22.041022	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.33.0	\N	\N	2682377906
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2026-03-05 03:46:22.07018	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.33.0	\N	\N	2682377906
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2026-03-05 03:46:22.078188	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.33.0	\N	\N	2682377906
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2026-03-05 03:46:22.136451	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.33.0	\N	\N	2682377906
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2026-03-05 03:46:22.140468	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.33.0	\N	\N	2682377906
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2026-03-05 03:46:22.186082	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.33.0	\N	\N	2682377906
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2026-03-05 03:46:22.190399	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.33.0	\N	\N	2682377906
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2026-03-05 03:46:22.196565	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.33.0	\N	\N	2682377906
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2026-03-05 03:46:22.244869	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.33.0	\N	\N	2682377906
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2026-03-05 03:46:22.27233	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.33.0	\N	\N	2682377906
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2026-03-05 03:46:22.275186	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.33.0	\N	\N	2682377906
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2026-03-05 03:46:22.304315	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.33.0	\N	\N	2682377906
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-03-05 03:46:22.31404	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.33.0	\N	\N	2682377906
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-03-05 03:46:22.316104	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2682377906
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-03-05 03:46:22.318987	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.33.0	\N	\N	2682377906
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-03-05 03:46:22.322107	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.33.0	\N	\N	2682377906
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2026-03-05 03:46:22.343982	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.33.0	\N	\N	2682377906
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2026-03-05 03:46:22.367612	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.33.0	\N	\N	2682377906
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2026-03-05 03:46:22.372938	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.33.0	\N	\N	2682377906
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-03-05 03:46:24.719213	119	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.33.0	\N	\N	2682377906
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2026-03-05 03:46:22.376888	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.33.0	\N	\N	2682377906
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2026-03-05 03:46:22.380206	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.33.0	\N	\N	2682377906
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2026-03-05 03:46:22.439728	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.33.0	\N	\N	2682377906
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2026-03-05 03:46:22.445205	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.33.0	\N	\N	2682377906
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2026-03-05 03:46:22.447085	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.33.0	\N	\N	2682377906
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2026-03-05 03:46:22.683548	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.33.0	\N	\N	2682377906
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2026-03-05 03:46:22.711198	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.33.0	\N	\N	2682377906
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2026-03-05 03:46:22.713835	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.33.0	\N	\N	2682377906
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2026-03-05 03:46:22.733364	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.33.0	\N	\N	2682377906
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2026-03-05 03:46:22.741821	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.33.0	\N	\N	2682377906
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2026-03-05 03:46:22.753482	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.33.0	\N	\N	2682377906
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2026-03-05 03:46:22.75805	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.33.0	\N	\N	2682377906
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-03-05 03:46:22.763752	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2682377906
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-03-05 03:46:22.765769	34	MARK_RAN	9:f9753208029f582525ed12011a19d054	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.33.0	\N	\N	2682377906
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-03-05 03:46:22.779048	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.33.0	\N	\N	2682377906
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2026-03-05 03:46:22.78383	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.33.0	\N	\N	2682377906
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-03-05 03:46:22.787449	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	2682377906
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2026-03-05 03:46:22.790876	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.33.0	\N	\N	2682377906
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2026-03-05 03:46:22.794309	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.33.0	\N	\N	2682377906
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-03-05 03:46:22.795951	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.33.0	\N	\N	2682377906
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-03-05 03:46:22.798016	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.33.0	\N	\N	2682377906
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2026-03-05 03:46:22.802009	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.33.0	\N	\N	2682377906
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-03-05 03:46:23.601374	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.33.0	\N	\N	2682377906
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2026-03-05 03:46:23.605358	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.33.0	\N	\N	2682377906
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-03-05 03:46:23.609162	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.33.0	\N	\N	2682377906
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-03-05 03:46:23.612451	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.33.0	\N	\N	2682377906
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-03-05 03:46:23.614122	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.33.0	\N	\N	2682377906
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-03-05 03:46:23.672376	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.33.0	\N	\N	2682377906
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-03-05 03:46:23.676259	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.33.0	\N	\N	2682377906
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2026-03-05 03:46:23.688795	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.33.0	\N	\N	2682377906
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2026-03-05 03:46:23.868118	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.33.0	\N	\N	2682377906
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2026-03-05 03:46:23.872036	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2682377906
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2026-03-05 03:46:23.875128	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.33.0	\N	\N	2682377906
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2026-03-05 03:46:23.877957	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.33.0	\N	\N	2682377906
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-03-05 03:46:23.882284	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.33.0	\N	\N	2682377906
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-03-05 03:46:23.886334	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.33.0	\N	\N	2682377906
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-03-05 03:46:23.911461	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.33.0	\N	\N	2682377906
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-03-05 03:46:24.098192	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.33.0	\N	\N	2682377906
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2026-03-05 03:46:24.111154	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.33.0	\N	\N	2682377906
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2026-03-05 03:46:24.117093	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.33.0	\N	\N	2682377906
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-03-05 03:46:24.124255	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.33.0	\N	\N	2682377906
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-03-05 03:46:24.128217	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.33.0	\N	\N	2682377906
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2026-03-05 03:46:24.13176	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.33.0	\N	\N	2682377906
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2026-03-05 03:46:24.134989	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.33.0	\N	\N	2682377906
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2026-03-05 03:46:24.138022	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.33.0	\N	\N	2682377906
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2026-03-05 03:46:24.161586	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.33.0	\N	\N	2682377906
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2026-03-05 03:46:24.182941	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.33.0	\N	\N	2682377906
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2026-03-05 03:46:24.18775	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.33.0	\N	\N	2682377906
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2026-03-05 03:46:24.213266	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.33.0	\N	\N	2682377906
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2026-03-05 03:46:24.219177	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.33.0	\N	\N	2682377906
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2026-03-05 03:46:24.22412	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.33.0	\N	\N	2682377906
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-03-05 03:46:24.230031	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.33.0	\N	\N	2682377906
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-03-05 03:46:24.235301	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.33.0	\N	\N	2682377906
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-03-05 03:46:24.237576	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.33.0	\N	\N	2682377906
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-03-05 03:46:24.253937	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.33.0	\N	\N	2682377906
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-03-05 03:46:24.292638	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.33.0	\N	\N	2682377906
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-03-05 03:46:24.297738	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.33.0	\N	\N	2682377906
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-03-05 03:46:24.29966	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.33.0	\N	\N	2682377906
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-03-05 03:46:24.309715	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.33.0	\N	\N	2682377906
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-03-05 03:46:24.311676	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.33.0	\N	\N	2682377906
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-03-05 03:46:24.339234	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.33.0	\N	\N	2682377906
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-03-05 03:46:24.341422	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	2682377906
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-03-05 03:46:24.34746	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	2682377906
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-03-05 03:46:24.349523	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	2682377906
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-03-05 03:46:24.377149	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.33.0	\N	\N	2682377906
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2026-03-05 03:46:24.381537	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.33.0	\N	\N	2682377906
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-03-05 03:46:24.387679	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.33.0	\N	\N	2682377906
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-03-05 03:46:24.39286	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.33.0	\N	\N	2682377906
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-03-05 03:46:24.397808	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.33.0	\N	\N	2682377906
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-03-05 03:46:24.402465	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.33.0	\N	\N	2682377906
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-03-05 03:46:24.428676	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2682377906
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-03-05 03:46:24.434132	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.33.0	\N	\N	2682377906
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-03-05 03:46:24.435948	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.33.0	\N	\N	2682377906
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-03-05 03:46:24.441365	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.33.0	\N	\N	2682377906
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-03-05 03:46:24.443346	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.33.0	\N	\N	2682377906
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-03-05 03:46:24.448917	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.33.0	\N	\N	2682377906
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-03-05 03:46:24.512433	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2682377906
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-03-05 03:46:24.514584	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2682377906
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-03-05 03:46:24.521883	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2682377906
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-03-05 03:46:24.541457	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2682377906
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-03-05 03:46:24.543611	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2682377906
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-03-05 03:46:24.564725	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.33.0	\N	\N	2682377906
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-03-05 03:46:24.567841	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.33.0	\N	\N	2682377906
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2026-03-05 03:46:24.572495	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.33.0	\N	\N	2682377906
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2026-03-05 03:46:24.591188	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.33.0	\N	\N	2682377906
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2026-03-05 03:46:24.610313	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.33.0	\N	\N	2682377906
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2026-03-05 03:46:24.632968	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.33.0	\N	\N	2682377906
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2026-03-05 03:46:24.636114	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.33.0	\N	\N	2682377906
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-03-05 03:46:24.656938	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.33.0	\N	\N	2682377906
20.0.0-12964-supported-dbs-edb-migration	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-03-05 03:46:24.68181	110	EXECUTED	9:a6b18a8e38062df5793edbe064f4aecd	dropIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE; createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.33.0	\N	\N	2682377906
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-03-05 03:46:24.683611	111	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.33.0	\N	\N	2682377906
client-attributes-string-accomodation-fixed-pre-drop-index	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-03-05 03:46:24.688742	112	EXECUTED	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2682377906
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-03-05 03:46:24.694932	113	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2682377906
client-attributes-string-accomodation-fixed-post-create-index	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-03-05 03:46:24.696818	114	MARK_RAN	9:bd2bd0fc7768cf0845ac96a8786fa735	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2682377906
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2026-03-05 03:46:24.701447	115	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.33.0	\N	\N	2682377906
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-03-05 03:46:24.71043	116	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.33.0	\N	\N	2682377906
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-03-05 03:46:24.713079	117	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.33.0	\N	\N	2682377906
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-03-05 03:46:24.717498	118	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.33.0	\N	\N	2682377906
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-03-05 03:46:24.724574	120	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.33.0	\N	\N	2682377906
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-03-05 03:46:24.729049	121	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.33.0	\N	\N	2682377906
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-03-05 03:46:24.794636	122	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.33.0	\N	\N	2682377906
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-03-05 03:46:24.797863	123	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.33.0	\N	\N	2682377906
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-03-05 03:46:24.801761	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2682377906
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-03-05 03:46:24.821844	125	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2682377906
24.0.0-26618-edb-migration	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-03-05 03:46:24.845298	126	EXECUTED	9:2f684b29d414cd47efe3a3599f390741	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES; createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2682377906
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-03-05 03:46:24.848691	127	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.33.0	\N	\N	2682377906
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-03-05 03:46:24.850963	128	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2682377906
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-03-05 03:46:24.853637	129	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2682377906
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-03-05 03:46:24.858205	130	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	2682377906
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-03-05 03:46:24.878493	131	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2682377906
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-03-05 03:46:24.884741	132	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2682377906
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-03-05 03:46:24.897053	133	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2682377906
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-03-05 03:46:24.905893	134	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2682377906
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-03-05 03:46:24.912673	135	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	2682377906
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-03-05 03:46:24.91464	136	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2682377906
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-03-05 03:46:24.935405	137	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2682377906
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-03-05 03:46:24.941798	138	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.33.0	\N	\N	2682377906
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-03-05 03:46:24.947059	139	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.33.0	\N	\N	2682377906
unique-consentuser-edb-migration	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-03-05 03:46:24.951395	140	MARK_RAN	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.33.0	\N	\N	2682377906
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-03-05 03:46:24.953498	141	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.33.0	\N	\N	2682377906
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-03-05 03:46:24.987762	142	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.33.0	\N	\N	2682377906
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-03-05 03:46:24.992792	143	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.33.0	\N	\N	2682377906
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-03-05 03:46:24.999938	144	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.33.0	\N	\N	2682377906
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-03-05 03:46:25.018258	145	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.33.0	\N	\N	2682377906
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-03-05 03:46:25.022415	146	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.33.0	\N	\N	2682377906
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-03-05 03:46:25.026755	147	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.33.0	\N	\N	2682377906
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-03-05 03:46:25.045252	148	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.33.0	\N	\N	2682377906
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-03-05 03:46:25.078853	149	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.33.0	\N	\N	2682377906
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-03-05 03:46:25.084131	150	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	2682377906
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-03-05 03:46:25.091365	151	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.33.0	\N	\N	2682377906
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-03-05 03:46:25.094495	152	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.33.0	\N	\N	2682377906
29399-jdbc-ping-default	keycloak	META-INF/jpa-changelog-26.1.0.xml	2026-03-05 03:46:25.098526	153	EXECUTED	9:007dbe99d7203fca403b89d4edfdf21e	createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING		\N	4.33.0	\N	\N	2682377906
26.1.0-34013	keycloak	META-INF/jpa-changelog-26.1.0.xml	2026-03-05 03:46:25.102627	154	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.33.0	\N	\N	2682377906
26.1.0-34380	keycloak	META-INF/jpa-changelog-26.1.0.xml	2026-03-05 03:46:25.106075	155	EXECUTED	9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01	dropTable tableName=USERNAME_LOGIN_FAILURE		\N	4.33.0	\N	\N	2682377906
26.2.0-36750	keycloak	META-INF/jpa-changelog-26.2.0.xml	2026-03-05 03:46:25.110388	156	EXECUTED	9:b49ce951c22f7eb16480ff085640a33a	createTable tableName=SERVER_CONFIG		\N	4.33.0	\N	\N	2682377906
26.2.0-26106	keycloak	META-INF/jpa-changelog-26.2.0.xml	2026-03-05 03:46:25.114215	157	EXECUTED	9:b5877d5dab7d10ff3a9d209d7beb6680	addColumn tableName=CREDENTIAL		\N	4.33.0	\N	\N	2682377906
26.2.6-39866-duplicate	keycloak	META-INF/jpa-changelog-26.2.6.xml	2026-03-05 03:46:25.117616	158	EXECUTED	9:1dc67ccee24f30331db2cba4f372e40e	customChange		\N	4.33.0	\N	\N	2682377906
26.2.6-39866-uk	keycloak	META-INF/jpa-changelog-26.2.6.xml	2026-03-05 03:46:25.120915	159	EXECUTED	9:b70b76f47210cf0a5f4ef0e219eac7cd	addUniqueConstraint constraintName=UK_MIGRATION_VERSION, tableName=MIGRATION_MODEL		\N	4.33.0	\N	\N	2682377906
26.2.6-40088-duplicate	keycloak	META-INF/jpa-changelog-26.2.6.xml	2026-03-05 03:46:25.123815	160	EXECUTED	9:cc7e02ed69ab31979afb1982f9670e8f	customChange		\N	4.33.0	\N	\N	2682377906
26.2.6-40088-uk	keycloak	META-INF/jpa-changelog-26.2.6.xml	2026-03-05 03:46:25.126963	161	EXECUTED	9:5bb848128da7bc4595cc507383325241	addUniqueConstraint constraintName=UK_MIGRATION_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.33.0	\N	\N	2682377906
26.3.0-groups-description	keycloak	META-INF/jpa-changelog-26.3.0.xml	2026-03-05 03:46:25.130256	162	EXECUTED	9:e1a3c05574326fb5b246b73b9a4c4d49	addColumn tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	2682377906
26.4.0-40933-saml-encryption-attributes	keycloak	META-INF/jpa-changelog-26.4.0.xml	2026-03-05 03:46:25.133045	163	EXECUTED	9:7e9eaba362ca105efdda202303a4fe49	customChange		\N	4.33.0	\N	\N	2682377906
26.4.0-51321	keycloak	META-INF/jpa-changelog-26.4.0.xml	2026-03-05 03:46:25.150668	164	EXECUTED	9:34bab2bc56f75ffd7e347c580874e306	createIndex indexName=IDX_EVENT_ENTITY_USER_ID_TYPE, tableName=EVENT_ENTITY		\N	4.33.0	\N	\N	2682377906
40343-workflow-state-table	keycloak	META-INF/jpa-changelog-26.4.0.xml	2026-03-05 03:46:25.190488	165	EXECUTED	9:ed3ab4723ceed210e5b5e60ac4562106	createTable tableName=WORKFLOW_STATE; addPrimaryKey constraintName=PK_WORKFLOW_STATE, tableName=WORKFLOW_STATE; addUniqueConstraint constraintName=UQ_WORKFLOW_RESOURCE, tableName=WORKFLOW_STATE; createIndex indexName=IDX_WORKFLOW_STATE_STEP, table...		\N	4.33.0	\N	\N	2682377906
26.5.0-index-offline-css-by-client	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-03-05 03:46:25.214038	166	EXECUTED	9:383e981ce95d16e32af757b7998820f7	createIndex indexName=IDX_OFFLINE_CSS_BY_CLIENT, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	2682377906
26.5.0-index-offline-css-by-client-storage-provider	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-03-05 03:46:25.237114	167	EXECUTED	9:f5bc200e6fa7d7e483854dee535ca425	createIndex indexName=IDX_OFFLINE_CSS_BY_CLIENT_STORAGE_PROVIDER, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	2682377906
26.5.0-idp-config-allow-null-fixed-drop-mssql-index	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-03-05 03:46:25.238894	168	MARK_RAN	9:50c51d2c98cd1d624eb1c485c3cf1f75	dropIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER		\N	4.33.0	\N	\N	2682377906
26.5.0-idp-config-allow-null	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-03-05 03:46:25.246515	169	EXECUTED	9:b667fb087874303b324c1af7fae4f606	dropDefaultValue columnName=TRUST_EMAIL, tableName=IDENTITY_PROVIDER; dropNotNullConstraint columnName=TRUST_EMAIL, tableName=IDENTITY_PROVIDER; dropNotNullConstraint columnName=STORE_TOKEN, tableName=IDENTITY_PROVIDER; dropDefaultValue columnName...		\N	4.33.0	\N	\N	2682377906
26.5.0-idp-config-allow-null-fixed-create-mssql-index	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-03-05 03:46:25.248202	170	MARK_RAN	9:dcbbb24c151c3b0b59f12fede23cc94d	createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER		\N	4.33.0	\N	\N	2682377906
26.5.0-remove-workflow-provider-id-column	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-03-05 03:46:25.271739	171	EXECUTED	9:d8eeb324484d45e946d03b953e168b21	dropIndex indexName=IDX_WORKFLOW_STATE_PROVIDER, tableName=WORKFLOW_STATE; createIndex indexName=IDX_WORKFLOW_STATE_PROVIDER, tableName=WORKFLOW_STATE; dropColumn columnName=WORKFLOW_PROVIDER_ID, tableName=WORKFLOW_STATE		\N	4.33.0	\N	\N	2682377906
26.5.0-add-remember-me	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-03-05 03:46:25.275638	172	EXECUTED	9:a7273ea8b21bd2f674c9c49141999f05	addColumn tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2682377906
26.5.0-add-sess-refresh-idx	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-03-05 03:46:25.296357	173	EXECUTED	9:ce49383d317ccbcd3434d1f21172b0b7	createIndex indexName=IDX_USER_SESSION_EXPIRATION_CREATED, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2682377906
26.5.0-add-sess-create-idx	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-03-05 03:46:25.318083	174	EXECUTED	9:aaee09e23a4d8468fbc5c51b7b314c58	createIndex indexName=IDX_USER_SESSION_EXPIRATION_LAST_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2682377906
26.5.0-drop-sess-refresh-idx	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-03-05 03:46:25.323859	175	EXECUTED	9:f0082210b6ccbbaf81287c27aa23753c	dropIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2682377906
26.5.0-mysql-mariadb-default-charset-collation	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-03-05 03:46:25.325467	176	MARK_RAN	9:1b383fa60d2db0a8952b365e725f9d16	customChange		\N	4.33.0	\N	\N	2682377906
26.5.0-invitations-table-fixed2	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-03-05 03:46:25.382238	177	EXECUTED	9:322cb11fc03181903dcd67a54f8b3cf0	createTable tableName=ORG_INVITATION; addForeignKeyConstraint baseTableName=ORG_INVITATION, constraintName=FK_ORG_INVITATION_ORG, referencedTableName=ORG; createIndex indexName=IDX_ORG_INVITATION_ORG_ID, tableName=ORG_INVITATION; createIndex index...		\N	4.33.0	\N	\N	2682377906
26.6.0-45009-broker-link-user-id	keycloak	META-INF/jpa-changelog-26.6.0.xml	2026-03-05 03:46:25.40373	178	EXECUTED	9:05026bbbc8d2ead5afcbda2f5fdf3a2b	createIndex indexName=IDX_BROKER_LINK_USER_ID, tableName=BROKER_LINK		\N	4.33.0	\N	\N	2682377906
26.6.0-45009-broker-link-identity-provider	keycloak	META-INF/jpa-changelog-26.6.0.xml	2026-03-05 03:46:25.425894	179	EXECUTED	9:7d9a0253c9de7be754efef8bba4265bd	createIndex indexName=IDX_BROKER_LINK_IDENTITY_PROVIDER, tableName=BROKER_LINK		\N	4.33.0	\N	\N	2682377906
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
451d845a-b81f-4125-b1b3-f3ec34d3cedb	b3c0ba04-1417-4a96-a8b1-2c4463d60e72	f
451d845a-b81f-4125-b1b3-f3ec34d3cedb	1790ddde-c126-4fa5-a371-c75359a7410f	t
451d845a-b81f-4125-b1b3-f3ec34d3cedb	2434f2de-a467-4d4e-be26-907104d937fe	t
451d845a-b81f-4125-b1b3-f3ec34d3cedb	b3fe39a2-aa3c-4200-b1aa-35faec841819	t
451d845a-b81f-4125-b1b3-f3ec34d3cedb	43b012ea-8f15-45d6-8463-e712cfc02822	t
451d845a-b81f-4125-b1b3-f3ec34d3cedb	094a2f4f-5d0d-4050-90ee-e20afc0a13f1	f
451d845a-b81f-4125-b1b3-f3ec34d3cedb	4ede134c-da0c-47e1-b344-33a7bf9b2217	f
451d845a-b81f-4125-b1b3-f3ec34d3cedb	2a28a7db-ed93-4f8c-9dcd-11d90420bb1c	t
451d845a-b81f-4125-b1b3-f3ec34d3cedb	819e2766-bafc-4fc2-af59-c425c564c7cb	t
451d845a-b81f-4125-b1b3-f3ec34d3cedb	a795626b-abcb-4b56-96c6-e919a6c6df56	f
451d845a-b81f-4125-b1b3-f3ec34d3cedb	ef06f1e6-4fb4-4790-97da-9cb81863e782	t
451d845a-b81f-4125-b1b3-f3ec34d3cedb	d15b0017-265e-4ce5-99a0-d8a4d94ce4a0	t
451d845a-b81f-4125-b1b3-f3ec34d3cedb	875bb6d8-7080-4498-9e56-413f752ca4db	f
41afada5-8096-4d14-92f4-5079d0a42a1d	09e2e827-08d2-4307-8cfc-154232c0ed0d	f
41afada5-8096-4d14-92f4-5079d0a42a1d	45f67aaf-3565-4e03-9a71-b8dd543a3fe4	t
41afada5-8096-4d14-92f4-5079d0a42a1d	431f950b-5b82-49f5-8c04-3008be7e32b9	t
41afada5-8096-4d14-92f4-5079d0a42a1d	0b612215-750f-4d9d-b909-46f4e0a54109	t
41afada5-8096-4d14-92f4-5079d0a42a1d	53c5f94b-f304-4ca3-88f1-3f70149806fc	t
41afada5-8096-4d14-92f4-5079d0a42a1d	4093ec20-f746-47c5-b92c-52eb67725380	f
41afada5-8096-4d14-92f4-5079d0a42a1d	37690b89-3dbf-4c0d-a02c-fee95835be61	f
41afada5-8096-4d14-92f4-5079d0a42a1d	79ff0bbd-45e6-4fbc-99da-d34ff22a6c14	t
41afada5-8096-4d14-92f4-5079d0a42a1d	d6f48ab8-ab41-45a8-a64b-9dd638c7ff5f	t
41afada5-8096-4d14-92f4-5079d0a42a1d	eb0bb277-713d-4a98-b782-a5b092d5ca75	f
41afada5-8096-4d14-92f4-5079d0a42a1d	6f0404c5-c6dd-4ea1-b145-591fe85595b6	t
41afada5-8096-4d14-92f4-5079d0a42a1d	b01e43af-0983-45b6-82a4-5cfa88d15700	t
41afada5-8096-4d14-92f4-5079d0a42a1d	3bf3c4d0-659b-4a7a-9e0a-614aba646317	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.jgroups_ping (address, name, cluster_name, ip, coord) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type, description) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
0188e131-5704-4cc9-92db-d30de3bab1b4	451d845a-b81f-4125-b1b3-f3ec34d3cedb	f	${role_default-roles}	default-roles-master	451d845a-b81f-4125-b1b3-f3ec34d3cedb	\N	\N
51ab19a8-a21d-4a78-aca0-5ca7146addb4	451d845a-b81f-4125-b1b3-f3ec34d3cedb	f	${role_admin}	admin	451d845a-b81f-4125-b1b3-f3ec34d3cedb	\N	\N
7cafcf4b-1ffb-440b-9d63-61bf66e800e2	451d845a-b81f-4125-b1b3-f3ec34d3cedb	f	${role_create-realm}	create-realm	451d845a-b81f-4125-b1b3-f3ec34d3cedb	\N	\N
01edd8e7-cb34-4f3a-a4f2-afba4953853f	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_create-client}	create-client	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
6075d2f9-10b7-43b8-93b7-1cca8e7f46ba	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_view-realm}	view-realm	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
76a09dfb-10af-401b-978a-3fc709496b4e	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_view-users}	view-users	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
685e1786-28fb-4c56-bcb3-926929a0b9c5	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_view-clients}	view-clients	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
18924356-32d5-4818-af50-67da6e0a8e03	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_view-events}	view-events	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
88d223a5-6b10-41f5-840d-d12597ea372e	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_view-identity-providers}	view-identity-providers	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
4a893a6c-5dd3-48d3-ad4c-6c7a066f370a	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_view-authorization}	view-authorization	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
5ab1b3bf-d645-401d-a3c6-ddc27292bb4f	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_manage-realm}	manage-realm	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
5ded7de1-d49f-455f-a15f-0b14b2950eeb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_manage-users}	manage-users	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
97c5b14f-c87f-4938-81e8-fc358d452ba8	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_manage-clients}	manage-clients	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
4badaf1e-4182-4b71-b513-fa84461083f6	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_manage-events}	manage-events	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
85b5a70c-2cb5-4f66-87c5-6f80c56089ba	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_manage-identity-providers}	manage-identity-providers	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
28037756-235d-4ea9-b876-8d63eceada5f	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_manage-authorization}	manage-authorization	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
d34a3077-a382-4d98-9752-ad9f6f6a3627	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_query-users}	query-users	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
934bb228-9b82-4c04-b574-a9d0cc487caf	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_query-clients}	query-clients	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
2e64f935-491e-45c0-9592-376b25af1f6d	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_query-realms}	query-realms	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
019df245-38fd-468e-90f4-f123e008e21f	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_query-groups}	query-groups	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
bdb894a6-41f0-4d71-84a4-9bf45f2cc569	aa93bd47-f839-4238-b0b0-fd0b9191ee08	t	${role_view-profile}	view-profile	451d845a-b81f-4125-b1b3-f3ec34d3cedb	aa93bd47-f839-4238-b0b0-fd0b9191ee08	\N
ba47cbd3-5ce9-4eae-9c4c-08b4994b64af	aa93bd47-f839-4238-b0b0-fd0b9191ee08	t	${role_manage-account}	manage-account	451d845a-b81f-4125-b1b3-f3ec34d3cedb	aa93bd47-f839-4238-b0b0-fd0b9191ee08	\N
0af35204-99bc-4ed0-bed4-bd272fda8987	aa93bd47-f839-4238-b0b0-fd0b9191ee08	t	${role_manage-account-links}	manage-account-links	451d845a-b81f-4125-b1b3-f3ec34d3cedb	aa93bd47-f839-4238-b0b0-fd0b9191ee08	\N
0fb15450-c7be-44a6-8b1c-b1f667b25523	aa93bd47-f839-4238-b0b0-fd0b9191ee08	t	${role_view-applications}	view-applications	451d845a-b81f-4125-b1b3-f3ec34d3cedb	aa93bd47-f839-4238-b0b0-fd0b9191ee08	\N
f39b4ce8-b27d-4cc7-a2c5-1e84d5a3c6c7	aa93bd47-f839-4238-b0b0-fd0b9191ee08	t	${role_view-consent}	view-consent	451d845a-b81f-4125-b1b3-f3ec34d3cedb	aa93bd47-f839-4238-b0b0-fd0b9191ee08	\N
faa7a960-f067-4d4a-bbf0-f21c6835688b	aa93bd47-f839-4238-b0b0-fd0b9191ee08	t	${role_manage-consent}	manage-consent	451d845a-b81f-4125-b1b3-f3ec34d3cedb	aa93bd47-f839-4238-b0b0-fd0b9191ee08	\N
5e7859b5-58f0-46a6-ad1c-488a3d20480b	aa93bd47-f839-4238-b0b0-fd0b9191ee08	t	${role_view-groups}	view-groups	451d845a-b81f-4125-b1b3-f3ec34d3cedb	aa93bd47-f839-4238-b0b0-fd0b9191ee08	\N
5b40942a-87c3-41cb-9312-ce2bab0886dc	aa93bd47-f839-4238-b0b0-fd0b9191ee08	t	${role_delete-account}	delete-account	451d845a-b81f-4125-b1b3-f3ec34d3cedb	aa93bd47-f839-4238-b0b0-fd0b9191ee08	\N
7221ede1-a026-4750-a54c-cf950ac25773	329e25c4-7e70-43eb-ab08-94d2cad785ee	t	${role_read-token}	read-token	451d845a-b81f-4125-b1b3-f3ec34d3cedb	329e25c4-7e70-43eb-ab08-94d2cad785ee	\N
a4e387fb-ff53-4dd6-8256-a8877e4d46df	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	t	${role_impersonation}	impersonation	451d845a-b81f-4125-b1b3-f3ec34d3cedb	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	\N
8478cda7-e6fe-41bb-bc75-780473d6af86	451d845a-b81f-4125-b1b3-f3ec34d3cedb	f	${role_offline-access}	offline_access	451d845a-b81f-4125-b1b3-f3ec34d3cedb	\N	\N
4c1aa771-3cdd-4760-a457-782dc86faee6	451d845a-b81f-4125-b1b3-f3ec34d3cedb	f	${role_uma_authorization}	uma_authorization	451d845a-b81f-4125-b1b3-f3ec34d3cedb	\N	\N
0c352c65-a053-46af-9cb1-2be7e5b9b943	41afada5-8096-4d14-92f4-5079d0a42a1d	f	${role_default-roles}	default-roles-stock-control-realm	41afada5-8096-4d14-92f4-5079d0a42a1d	\N	\N
61dadc45-58dc-4d35-a057-95eac4a9d0a8	39e121f1-0761-4d07-a046-8364e8007116	t	${role_create-client}	create-client	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
dd5ea0b2-5ceb-4a5a-a0bf-66c9dbb84a6a	39e121f1-0761-4d07-a046-8364e8007116	t	${role_view-realm}	view-realm	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
9499d3c3-c5fe-458e-ae30-ba6c126ae448	39e121f1-0761-4d07-a046-8364e8007116	t	${role_view-users}	view-users	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
11ead119-7862-4d2e-ab1e-2153e5f19e34	39e121f1-0761-4d07-a046-8364e8007116	t	${role_view-clients}	view-clients	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
4edd8846-473d-47c2-8f9f-50116dfd0ec1	39e121f1-0761-4d07-a046-8364e8007116	t	${role_view-events}	view-events	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
b58b118f-5e71-4e39-b9c2-f21a8fa2b5d8	39e121f1-0761-4d07-a046-8364e8007116	t	${role_view-identity-providers}	view-identity-providers	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
3e1d0e26-aa1e-4d1f-8534-242013e6eb98	39e121f1-0761-4d07-a046-8364e8007116	t	${role_view-authorization}	view-authorization	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
6117e325-c852-4bbf-98cf-b920c4af3a4b	39e121f1-0761-4d07-a046-8364e8007116	t	${role_manage-realm}	manage-realm	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
b52fa1a7-d064-48c1-b42b-35c8546369d6	39e121f1-0761-4d07-a046-8364e8007116	t	${role_manage-users}	manage-users	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
a7a0241b-7b2d-4f24-bc34-7cb0c5b32823	39e121f1-0761-4d07-a046-8364e8007116	t	${role_manage-clients}	manage-clients	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
1d0fe254-4bbe-4c46-be0f-da5a3485bff6	39e121f1-0761-4d07-a046-8364e8007116	t	${role_manage-events}	manage-events	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
12a7b9dc-fe26-47c0-8703-a9043fae4558	39e121f1-0761-4d07-a046-8364e8007116	t	${role_manage-identity-providers}	manage-identity-providers	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
415725b9-6a1b-42be-ab64-5e57e14de935	39e121f1-0761-4d07-a046-8364e8007116	t	${role_manage-authorization}	manage-authorization	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
9c7daa14-116c-42f8-bd89-7633e9775b26	39e121f1-0761-4d07-a046-8364e8007116	t	${role_query-users}	query-users	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
009e7f02-bc5c-4574-abc7-1488a0356dc8	39e121f1-0761-4d07-a046-8364e8007116	t	${role_query-clients}	query-clients	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
e8b807df-f473-4917-95bb-c39390c21900	39e121f1-0761-4d07-a046-8364e8007116	t	${role_query-realms}	query-realms	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
c5569887-bd79-46f5-9df1-c74a51656c32	39e121f1-0761-4d07-a046-8364e8007116	t	${role_query-groups}	query-groups	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
c85921f1-e77f-46e5-ba06-1afeb3eddd2f	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_realm-admin}	realm-admin	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
6e1d05b3-a718-4353-be4b-47da366900b4	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_create-client}	create-client	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
bf678d1c-d841-491d-afad-c3f9ea62d093	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_view-realm}	view-realm	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
11cfbd5c-5148-484c-a0b9-81e5c8b01ab9	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_view-users}	view-users	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
0dbd69b1-0072-4662-8781-186a48b0d373	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_view-clients}	view-clients	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
8c0ee46c-c45d-44b7-98f5-68f197cdd587	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_view-events}	view-events	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
497af44b-ea80-4d8e-b140-f7bf93bf65a8	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_view-identity-providers}	view-identity-providers	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
a9fb01af-a633-40a2-b657-c0c652853b13	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_view-authorization}	view-authorization	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
2354ef61-7727-41b2-87a2-4a9e5407b270	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_manage-realm}	manage-realm	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
be41ca3a-78ac-4f0d-8984-1250f2854e12	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_manage-users}	manage-users	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
3ed960bf-da8c-4179-950d-49111a8a2b4f	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_manage-clients}	manage-clients	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
cff43f60-10e4-4253-915d-d8ecb03c806f	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_manage-events}	manage-events	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
2ccb3e97-30ff-4087-8d72-c8d3bfef9400	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_manage-identity-providers}	manage-identity-providers	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
19af6633-3e12-4f4b-af6f-6941df6255f5	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_manage-authorization}	manage-authorization	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
7060a8c8-3c99-48ea-9016-4087b4424948	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_query-users}	query-users	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
22bdbb88-03d1-46d3-814c-587ada59eacc	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_query-clients}	query-clients	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
0c3e941e-5d2e-4583-9496-afe1ca154198	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_query-realms}	query-realms	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
73b434c4-d70e-4481-80ca-d24696e60946	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_query-groups}	query-groups	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
5611748f-92d7-492f-9b65-b519858e0880	bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	t	${role_view-profile}	view-profile	41afada5-8096-4d14-92f4-5079d0a42a1d	bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	\N
28d741ec-c313-43ef-ba5f-8602959e9787	bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	t	${role_manage-account}	manage-account	41afada5-8096-4d14-92f4-5079d0a42a1d	bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	\N
6f76ae52-e706-4435-8c97-d29958821459	bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	t	${role_manage-account-links}	manage-account-links	41afada5-8096-4d14-92f4-5079d0a42a1d	bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	\N
c51bf803-08a6-482f-a639-45a48f9fef70	bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	t	${role_view-applications}	view-applications	41afada5-8096-4d14-92f4-5079d0a42a1d	bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	\N
d19d84fc-70fe-4499-b018-80e724ff4036	bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	t	${role_view-consent}	view-consent	41afada5-8096-4d14-92f4-5079d0a42a1d	bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	\N
5135eec8-b038-4d55-9055-3e5035979d7d	bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	t	${role_manage-consent}	manage-consent	41afada5-8096-4d14-92f4-5079d0a42a1d	bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	\N
530ab8c0-acf9-4e9d-ae0a-87dc569a165d	bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	t	${role_view-groups}	view-groups	41afada5-8096-4d14-92f4-5079d0a42a1d	bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	\N
cffd8609-84cc-4b50-8ebe-e2214f033fbc	bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	t	${role_delete-account}	delete-account	41afada5-8096-4d14-92f4-5079d0a42a1d	bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	\N
bcef028c-4553-4a69-916d-2f9d5a7094db	39e121f1-0761-4d07-a046-8364e8007116	t	${role_impersonation}	impersonation	451d845a-b81f-4125-b1b3-f3ec34d3cedb	39e121f1-0761-4d07-a046-8364e8007116	\N
8e3227c1-507c-47d6-a0af-679a630493e0	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	t	${role_impersonation}	impersonation	41afada5-8096-4d14-92f4-5079d0a42a1d	8fe4303f-614e-4d4c-a007-cf0a6fc54d1e	\N
cf941636-313d-4c33-90d3-c2d5f3354766	ba53fa6d-43a7-46e9-8c75-adf9db8a3b1d	t	${role_read-token}	read-token	41afada5-8096-4d14-92f4-5079d0a42a1d	ba53fa6d-43a7-46e9-8c75-adf9db8a3b1d	\N
c2dca058-7202-4620-b0e0-db3442247fc4	41afada5-8096-4d14-92f4-5079d0a42a1d	f	${role_offline-access}	offline_access	41afada5-8096-4d14-92f4-5079d0a42a1d	\N	\N
e569af44-2819-4a4a-ae6b-6e6880c78f40	41afada5-8096-4d14-92f4-5079d0a42a1d	f	${role_uma_authorization}	uma_authorization	41afada5-8096-4d14-92f4-5079d0a42a1d	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.migration_model (id, version, update_time) FROM stdin;
khcgn	26.5.4	1772682387
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
1J7iSgiaTsMPmSgACg20nRrL	f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	0	1772730088	{"authMethod":"openid-connect","redirectUri":"http://localhost:8081/admin/master/console/","notes":{"clientId":"f0f68f03-f62d-42e3-8a6a-0b87849b4a9a","iss":"http://localhost:8081/realms/master","startedAt":"1772729954","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"5969e773-3f70-4050-95e9-f1fb7982ec0b","response_mode":"query","scope":"openid","userSessionStartedAt":"1772729954","redirect_uri":"http://localhost:8081/admin/master/console/","state":"e87f8330-03cf-4312-83b9-505c567be826","code_challenge":"KXJy9B0zKGQDR_dvpwxx4ouW-2IwYjMHHXq0pSHej08"}}	local	local	2
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version, remember_me) FROM stdin;
1J7iSgiaTsMPmSgACg20nRrL	949b1377-a910-4a0c-975b-c730c862f502	451d845a-b81f-4125-b1b3-f3ec34d3cedb	1772729954	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJXaW5kb3dzIiwib3NWZXJzaW9uIjoiMTAiLCJicm93c2VyIjoiQ2hyb21lLzE0NS4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1772729954","authenticators-completed":"{\\"b7e936ef-326d-4a9f-a533-490306758826\\":1772729954}"},"state":"LOGGED_IN"}	1772730088	\N	2	f
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: org_invitation; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.org_invitation (id, organization_id, email, first_name, last_name, created_at, expires_at, invite_link) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
f5976c9a-d6a2-48ea-b0cd-3eb36a70b69a	audience resolve	openid-connect	oidc-audience-resolve-mapper	1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	\N
f1425308-aaf3-4841-b5c2-2c40bc4c0397	locale	openid-connect	oidc-usermodel-attribute-mapper	f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	\N
7d602eb6-e7c5-4bb6-ac39-5ca1c5b06d3f	role list	saml	saml-role-list-mapper	\N	1790ddde-c126-4fa5-a371-c75359a7410f
0af7659b-37b9-4fe5-acd5-2fc807ed727c	organization	saml	saml-organization-membership-mapper	\N	2434f2de-a467-4d4e-be26-907104d937fe
5b9ee05e-c8e4-40a2-9e1c-67a5ce164bb4	full name	openid-connect	oidc-full-name-mapper	\N	b3fe39a2-aa3c-4200-b1aa-35faec841819
9290c3d7-9647-429b-8403-4d7a12cb28e1	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	b3fe39a2-aa3c-4200-b1aa-35faec841819
455c52f4-a28e-4546-a92b-61fd8b0cfbb7	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	b3fe39a2-aa3c-4200-b1aa-35faec841819
44c8dfdc-abc8-445f-95db-96a16f89d297	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	b3fe39a2-aa3c-4200-b1aa-35faec841819
e287080f-1e49-4271-a338-8cb89cc0256d	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	b3fe39a2-aa3c-4200-b1aa-35faec841819
88d96602-78e0-4744-8cf4-2cd36216b9b7	username	openid-connect	oidc-usermodel-attribute-mapper	\N	b3fe39a2-aa3c-4200-b1aa-35faec841819
7b1b80e9-c4ac-49e5-9d63-bf8d4e2b726e	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	b3fe39a2-aa3c-4200-b1aa-35faec841819
21c2292b-55e4-49ec-8ce8-8986a4774e4d	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	b3fe39a2-aa3c-4200-b1aa-35faec841819
f1faa78d-d712-46f5-9a50-bedfe30b0715	website	openid-connect	oidc-usermodel-attribute-mapper	\N	b3fe39a2-aa3c-4200-b1aa-35faec841819
7d2da438-6a3d-4c30-84dc-17a35d709b29	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	b3fe39a2-aa3c-4200-b1aa-35faec841819
f69ad2de-03c2-4d64-9cd6-cb9ae34d5381	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	b3fe39a2-aa3c-4200-b1aa-35faec841819
56403789-e686-4153-8256-f3d2e5d570a4	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	b3fe39a2-aa3c-4200-b1aa-35faec841819
16d8a2af-eca5-4b61-9277-e8bdf198e14e	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	b3fe39a2-aa3c-4200-b1aa-35faec841819
ab5c15dd-1cf4-4c11-870f-b12c0af6b401	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	b3fe39a2-aa3c-4200-b1aa-35faec841819
a9cdc73b-3f8e-4acc-9788-6de115758271	email	openid-connect	oidc-usermodel-attribute-mapper	\N	43b012ea-8f15-45d6-8463-e712cfc02822
ab56b98c-3a7f-4b7c-901f-ea7f0fbf8a46	email verified	openid-connect	oidc-usermodel-property-mapper	\N	43b012ea-8f15-45d6-8463-e712cfc02822
3fddb267-0c39-436f-9512-913e94f53b1c	address	openid-connect	oidc-address-mapper	\N	094a2f4f-5d0d-4050-90ee-e20afc0a13f1
7cd517f5-bb49-4e46-917b-8bf4d4d0dc9c	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	4ede134c-da0c-47e1-b344-33a7bf9b2217
31eb0e9b-7c19-4a70-8eca-3f0d2c5fa270	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	4ede134c-da0c-47e1-b344-33a7bf9b2217
52a6916b-884e-4a89-ba29-dc24c58d2e46	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	2a28a7db-ed93-4f8c-9dcd-11d90420bb1c
536ad4fa-e7d1-41bb-b97b-53118c534cee	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	2a28a7db-ed93-4f8c-9dcd-11d90420bb1c
82911b5c-2780-4d4c-b244-c5ff005bbef1	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	2a28a7db-ed93-4f8c-9dcd-11d90420bb1c
ff2ff175-f2ad-40b0-89cc-dd87b7c43ff3	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	819e2766-bafc-4fc2-af59-c425c564c7cb
2dfc3c1c-b494-4fd8-b208-6be977650bf9	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	a795626b-abcb-4b56-96c6-e919a6c6df56
1d4557d4-a854-4fe5-9c02-c198bc0a8b43	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	a795626b-abcb-4b56-96c6-e919a6c6df56
ecfc5374-2377-479c-97ea-048771ffbd60	acr loa level	openid-connect	oidc-acr-mapper	\N	ef06f1e6-4fb4-4790-97da-9cb81863e782
f5dc314f-ac4c-40ef-8c8d-e621c71119a3	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	d15b0017-265e-4ce5-99a0-d8a4d94ce4a0
a980991a-08b7-4a0a-a5f5-827b811e738f	sub	openid-connect	oidc-sub-mapper	\N	d15b0017-265e-4ce5-99a0-d8a4d94ce4a0
73e3a304-bfcf-476e-9301-b375c5c2f93c	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	99b3fe20-a636-4917-8579-0aa5821450ec
cf891011-1414-496d-91be-66ef055899d1	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	99b3fe20-a636-4917-8579-0aa5821450ec
342b419d-5a38-424d-94a8-175a31a85d70	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	99b3fe20-a636-4917-8579-0aa5821450ec
18829b8a-43e9-4982-8364-8fe07988f2ca	organization	openid-connect	oidc-organization-membership-mapper	\N	875bb6d8-7080-4498-9e56-413f752ca4db
be021eed-662e-4fc0-90fc-fa4c12b845d6	audience resolve	openid-connect	oidc-audience-resolve-mapper	ee1ad023-81cc-4905-86cc-3bb0a80bb7da	\N
58984c5b-4cf1-44a2-b734-f39e3e4ddfcb	role list	saml	saml-role-list-mapper	\N	45f67aaf-3565-4e03-9a71-b8dd543a3fe4
a299ca67-2d4a-4e79-8af2-485e9bdb7ed4	organization	saml	saml-organization-membership-mapper	\N	431f950b-5b82-49f5-8c04-3008be7e32b9
21c5766f-0a16-4794-a6a2-6914473e1b57	full name	openid-connect	oidc-full-name-mapper	\N	0b612215-750f-4d9d-b909-46f4e0a54109
e1145f32-78b7-418c-9ef9-8428d2ceacfc	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	0b612215-750f-4d9d-b909-46f4e0a54109
4e8ffc7b-f23e-49c2-a6a6-7b4c9bfc5173	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	0b612215-750f-4d9d-b909-46f4e0a54109
d4df5b77-e03e-4d11-84c4-a5cb3d756050	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	0b612215-750f-4d9d-b909-46f4e0a54109
1afc9c88-9c87-4040-985c-2026e6b8c2cb	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	0b612215-750f-4d9d-b909-46f4e0a54109
998b9f88-7de4-4486-aeac-75e13a575b13	username	openid-connect	oidc-usermodel-attribute-mapper	\N	0b612215-750f-4d9d-b909-46f4e0a54109
8a122125-9e7e-42ab-b1c7-d04071ffab4c	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	0b612215-750f-4d9d-b909-46f4e0a54109
9c70b06d-b159-4929-8f09-c24ac3426296	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	0b612215-750f-4d9d-b909-46f4e0a54109
71d2cb05-f163-4e27-96ce-02bfbb576808	website	openid-connect	oidc-usermodel-attribute-mapper	\N	0b612215-750f-4d9d-b909-46f4e0a54109
c7e74174-16ad-4887-852a-972e7cbf2e60	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	0b612215-750f-4d9d-b909-46f4e0a54109
9e7678b7-d228-4202-b759-68f2205c31b8	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	0b612215-750f-4d9d-b909-46f4e0a54109
cecfb7ae-8fad-4b11-9051-b7faf054a96c	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	0b612215-750f-4d9d-b909-46f4e0a54109
7b6c2726-d2f0-444f-8b8a-17dde7d20ff0	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	0b612215-750f-4d9d-b909-46f4e0a54109
fcfe135e-10a9-4ddf-abf5-06d14e0ce49b	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	0b612215-750f-4d9d-b909-46f4e0a54109
aad570fc-6c36-4987-9c1f-96172631ffb3	email	openid-connect	oidc-usermodel-attribute-mapper	\N	53c5f94b-f304-4ca3-88f1-3f70149806fc
94345099-67e1-44e7-8bfc-98bd69a73098	email verified	openid-connect	oidc-usermodel-property-mapper	\N	53c5f94b-f304-4ca3-88f1-3f70149806fc
063938f0-3676-4213-909a-9649ebe95fbd	address	openid-connect	oidc-address-mapper	\N	4093ec20-f746-47c5-b92c-52eb67725380
2c5aa5d1-ed2f-438f-9b98-b4d769b9b7d3	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	37690b89-3dbf-4c0d-a02c-fee95835be61
c5ef4e77-9d43-44b7-b2f3-f55ddaaedb58	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	37690b89-3dbf-4c0d-a02c-fee95835be61
b492e573-3127-4531-bad6-69c7f4e0037e	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	79ff0bbd-45e6-4fbc-99da-d34ff22a6c14
ffb90e0c-a7e0-454d-bd27-1162e7680110	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	79ff0bbd-45e6-4fbc-99da-d34ff22a6c14
c64ce5ad-fc16-41bd-b372-e6780cc1d201	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	79ff0bbd-45e6-4fbc-99da-d34ff22a6c14
55c82e62-f173-416c-9657-0e0666200068	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	d6f48ab8-ab41-45a8-a64b-9dd638c7ff5f
459e0803-dc35-4a3b-9716-2c3a55a67000	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	eb0bb277-713d-4a98-b782-a5b092d5ca75
c5e4b27a-070f-40d5-8a4f-5073838b8eab	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	eb0bb277-713d-4a98-b782-a5b092d5ca75
88f56698-a2e4-4f53-932f-714d790983fc	acr loa level	openid-connect	oidc-acr-mapper	\N	6f0404c5-c6dd-4ea1-b145-591fe85595b6
d95dedab-014c-45a5-a136-ee3473152e56	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	b01e43af-0983-45b6-82a4-5cfa88d15700
37c10136-8076-4d57-b4fd-f01865126bed	sub	openid-connect	oidc-sub-mapper	\N	b01e43af-0983-45b6-82a4-5cfa88d15700
dec6eb81-5f38-4e84-b548-9e7f49fd44d9	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	fffe9976-b280-4c5f-8705-2be08afae48f
6e2638a2-2bb7-42e6-b321-442f9d6a21dd	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	fffe9976-b280-4c5f-8705-2be08afae48f
d80747cc-13f8-4f6b-a508-325a5b3e567a	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	fffe9976-b280-4c5f-8705-2be08afae48f
4762ad0b-bc54-4aa1-abcd-8c37bdf4c28a	organization	openid-connect	oidc-organization-membership-mapper	\N	3bf3c4d0-659b-4a7a-9e0a-614aba646317
a3ced95a-3fff-4afc-8309-e74f8213c5a9	locale	openid-connect	oidc-usermodel-attribute-mapper	a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
f1425308-aaf3-4841-b5c2-2c40bc4c0397	true	introspection.token.claim
f1425308-aaf3-4841-b5c2-2c40bc4c0397	true	userinfo.token.claim
f1425308-aaf3-4841-b5c2-2c40bc4c0397	locale	user.attribute
f1425308-aaf3-4841-b5c2-2c40bc4c0397	true	id.token.claim
f1425308-aaf3-4841-b5c2-2c40bc4c0397	true	access.token.claim
f1425308-aaf3-4841-b5c2-2c40bc4c0397	locale	claim.name
f1425308-aaf3-4841-b5c2-2c40bc4c0397	String	jsonType.label
7d602eb6-e7c5-4bb6-ac39-5ca1c5b06d3f	false	single
7d602eb6-e7c5-4bb6-ac39-5ca1c5b06d3f	Basic	attribute.nameformat
7d602eb6-e7c5-4bb6-ac39-5ca1c5b06d3f	Role	attribute.name
16d8a2af-eca5-4b61-9277-e8bdf198e14e	true	introspection.token.claim
16d8a2af-eca5-4b61-9277-e8bdf198e14e	true	userinfo.token.claim
16d8a2af-eca5-4b61-9277-e8bdf198e14e	locale	user.attribute
16d8a2af-eca5-4b61-9277-e8bdf198e14e	true	id.token.claim
16d8a2af-eca5-4b61-9277-e8bdf198e14e	true	access.token.claim
16d8a2af-eca5-4b61-9277-e8bdf198e14e	locale	claim.name
16d8a2af-eca5-4b61-9277-e8bdf198e14e	String	jsonType.label
21c2292b-55e4-49ec-8ce8-8986a4774e4d	true	introspection.token.claim
21c2292b-55e4-49ec-8ce8-8986a4774e4d	true	userinfo.token.claim
21c2292b-55e4-49ec-8ce8-8986a4774e4d	picture	user.attribute
21c2292b-55e4-49ec-8ce8-8986a4774e4d	true	id.token.claim
21c2292b-55e4-49ec-8ce8-8986a4774e4d	true	access.token.claim
21c2292b-55e4-49ec-8ce8-8986a4774e4d	picture	claim.name
21c2292b-55e4-49ec-8ce8-8986a4774e4d	String	jsonType.label
44c8dfdc-abc8-445f-95db-96a16f89d297	true	introspection.token.claim
44c8dfdc-abc8-445f-95db-96a16f89d297	true	userinfo.token.claim
44c8dfdc-abc8-445f-95db-96a16f89d297	middleName	user.attribute
44c8dfdc-abc8-445f-95db-96a16f89d297	true	id.token.claim
44c8dfdc-abc8-445f-95db-96a16f89d297	true	access.token.claim
44c8dfdc-abc8-445f-95db-96a16f89d297	middle_name	claim.name
44c8dfdc-abc8-445f-95db-96a16f89d297	String	jsonType.label
455c52f4-a28e-4546-a92b-61fd8b0cfbb7	true	introspection.token.claim
455c52f4-a28e-4546-a92b-61fd8b0cfbb7	true	userinfo.token.claim
455c52f4-a28e-4546-a92b-61fd8b0cfbb7	firstName	user.attribute
455c52f4-a28e-4546-a92b-61fd8b0cfbb7	true	id.token.claim
455c52f4-a28e-4546-a92b-61fd8b0cfbb7	true	access.token.claim
455c52f4-a28e-4546-a92b-61fd8b0cfbb7	given_name	claim.name
455c52f4-a28e-4546-a92b-61fd8b0cfbb7	String	jsonType.label
56403789-e686-4153-8256-f3d2e5d570a4	true	introspection.token.claim
56403789-e686-4153-8256-f3d2e5d570a4	true	userinfo.token.claim
56403789-e686-4153-8256-f3d2e5d570a4	zoneinfo	user.attribute
56403789-e686-4153-8256-f3d2e5d570a4	true	id.token.claim
56403789-e686-4153-8256-f3d2e5d570a4	true	access.token.claim
56403789-e686-4153-8256-f3d2e5d570a4	zoneinfo	claim.name
56403789-e686-4153-8256-f3d2e5d570a4	String	jsonType.label
5b9ee05e-c8e4-40a2-9e1c-67a5ce164bb4	true	introspection.token.claim
5b9ee05e-c8e4-40a2-9e1c-67a5ce164bb4	true	userinfo.token.claim
5b9ee05e-c8e4-40a2-9e1c-67a5ce164bb4	true	id.token.claim
5b9ee05e-c8e4-40a2-9e1c-67a5ce164bb4	true	access.token.claim
7b1b80e9-c4ac-49e5-9d63-bf8d4e2b726e	true	introspection.token.claim
7b1b80e9-c4ac-49e5-9d63-bf8d4e2b726e	true	userinfo.token.claim
7b1b80e9-c4ac-49e5-9d63-bf8d4e2b726e	profile	user.attribute
7b1b80e9-c4ac-49e5-9d63-bf8d4e2b726e	true	id.token.claim
7b1b80e9-c4ac-49e5-9d63-bf8d4e2b726e	true	access.token.claim
7b1b80e9-c4ac-49e5-9d63-bf8d4e2b726e	profile	claim.name
7b1b80e9-c4ac-49e5-9d63-bf8d4e2b726e	String	jsonType.label
7d2da438-6a3d-4c30-84dc-17a35d709b29	true	introspection.token.claim
7d2da438-6a3d-4c30-84dc-17a35d709b29	true	userinfo.token.claim
7d2da438-6a3d-4c30-84dc-17a35d709b29	gender	user.attribute
7d2da438-6a3d-4c30-84dc-17a35d709b29	true	id.token.claim
7d2da438-6a3d-4c30-84dc-17a35d709b29	true	access.token.claim
7d2da438-6a3d-4c30-84dc-17a35d709b29	gender	claim.name
7d2da438-6a3d-4c30-84dc-17a35d709b29	String	jsonType.label
88d96602-78e0-4744-8cf4-2cd36216b9b7	true	introspection.token.claim
88d96602-78e0-4744-8cf4-2cd36216b9b7	true	userinfo.token.claim
88d96602-78e0-4744-8cf4-2cd36216b9b7	username	user.attribute
88d96602-78e0-4744-8cf4-2cd36216b9b7	true	id.token.claim
88d96602-78e0-4744-8cf4-2cd36216b9b7	true	access.token.claim
88d96602-78e0-4744-8cf4-2cd36216b9b7	preferred_username	claim.name
88d96602-78e0-4744-8cf4-2cd36216b9b7	String	jsonType.label
9290c3d7-9647-429b-8403-4d7a12cb28e1	true	introspection.token.claim
9290c3d7-9647-429b-8403-4d7a12cb28e1	true	userinfo.token.claim
9290c3d7-9647-429b-8403-4d7a12cb28e1	lastName	user.attribute
9290c3d7-9647-429b-8403-4d7a12cb28e1	true	id.token.claim
9290c3d7-9647-429b-8403-4d7a12cb28e1	true	access.token.claim
9290c3d7-9647-429b-8403-4d7a12cb28e1	family_name	claim.name
9290c3d7-9647-429b-8403-4d7a12cb28e1	String	jsonType.label
ab5c15dd-1cf4-4c11-870f-b12c0af6b401	true	introspection.token.claim
ab5c15dd-1cf4-4c11-870f-b12c0af6b401	true	userinfo.token.claim
ab5c15dd-1cf4-4c11-870f-b12c0af6b401	updatedAt	user.attribute
ab5c15dd-1cf4-4c11-870f-b12c0af6b401	true	id.token.claim
ab5c15dd-1cf4-4c11-870f-b12c0af6b401	true	access.token.claim
ab5c15dd-1cf4-4c11-870f-b12c0af6b401	updated_at	claim.name
ab5c15dd-1cf4-4c11-870f-b12c0af6b401	long	jsonType.label
e287080f-1e49-4271-a338-8cb89cc0256d	true	introspection.token.claim
e287080f-1e49-4271-a338-8cb89cc0256d	true	userinfo.token.claim
e287080f-1e49-4271-a338-8cb89cc0256d	nickname	user.attribute
e287080f-1e49-4271-a338-8cb89cc0256d	true	id.token.claim
e287080f-1e49-4271-a338-8cb89cc0256d	true	access.token.claim
e287080f-1e49-4271-a338-8cb89cc0256d	nickname	claim.name
e287080f-1e49-4271-a338-8cb89cc0256d	String	jsonType.label
f1faa78d-d712-46f5-9a50-bedfe30b0715	true	introspection.token.claim
f1faa78d-d712-46f5-9a50-bedfe30b0715	true	userinfo.token.claim
f1faa78d-d712-46f5-9a50-bedfe30b0715	website	user.attribute
f1faa78d-d712-46f5-9a50-bedfe30b0715	true	id.token.claim
f1faa78d-d712-46f5-9a50-bedfe30b0715	true	access.token.claim
f1faa78d-d712-46f5-9a50-bedfe30b0715	website	claim.name
f1faa78d-d712-46f5-9a50-bedfe30b0715	String	jsonType.label
f69ad2de-03c2-4d64-9cd6-cb9ae34d5381	true	introspection.token.claim
f69ad2de-03c2-4d64-9cd6-cb9ae34d5381	true	userinfo.token.claim
f69ad2de-03c2-4d64-9cd6-cb9ae34d5381	birthdate	user.attribute
f69ad2de-03c2-4d64-9cd6-cb9ae34d5381	true	id.token.claim
f69ad2de-03c2-4d64-9cd6-cb9ae34d5381	true	access.token.claim
f69ad2de-03c2-4d64-9cd6-cb9ae34d5381	birthdate	claim.name
f69ad2de-03c2-4d64-9cd6-cb9ae34d5381	String	jsonType.label
a9cdc73b-3f8e-4acc-9788-6de115758271	true	introspection.token.claim
a9cdc73b-3f8e-4acc-9788-6de115758271	true	userinfo.token.claim
a9cdc73b-3f8e-4acc-9788-6de115758271	email	user.attribute
a9cdc73b-3f8e-4acc-9788-6de115758271	true	id.token.claim
a9cdc73b-3f8e-4acc-9788-6de115758271	true	access.token.claim
a9cdc73b-3f8e-4acc-9788-6de115758271	email	claim.name
a9cdc73b-3f8e-4acc-9788-6de115758271	String	jsonType.label
ab56b98c-3a7f-4b7c-901f-ea7f0fbf8a46	true	introspection.token.claim
ab56b98c-3a7f-4b7c-901f-ea7f0fbf8a46	true	userinfo.token.claim
ab56b98c-3a7f-4b7c-901f-ea7f0fbf8a46	emailVerified	user.attribute
ab56b98c-3a7f-4b7c-901f-ea7f0fbf8a46	true	id.token.claim
ab56b98c-3a7f-4b7c-901f-ea7f0fbf8a46	true	access.token.claim
ab56b98c-3a7f-4b7c-901f-ea7f0fbf8a46	email_verified	claim.name
ab56b98c-3a7f-4b7c-901f-ea7f0fbf8a46	boolean	jsonType.label
3fddb267-0c39-436f-9512-913e94f53b1c	formatted	user.attribute.formatted
3fddb267-0c39-436f-9512-913e94f53b1c	country	user.attribute.country
3fddb267-0c39-436f-9512-913e94f53b1c	true	introspection.token.claim
3fddb267-0c39-436f-9512-913e94f53b1c	postal_code	user.attribute.postal_code
3fddb267-0c39-436f-9512-913e94f53b1c	true	userinfo.token.claim
3fddb267-0c39-436f-9512-913e94f53b1c	street	user.attribute.street
3fddb267-0c39-436f-9512-913e94f53b1c	true	id.token.claim
3fddb267-0c39-436f-9512-913e94f53b1c	region	user.attribute.region
3fddb267-0c39-436f-9512-913e94f53b1c	true	access.token.claim
3fddb267-0c39-436f-9512-913e94f53b1c	locality	user.attribute.locality
31eb0e9b-7c19-4a70-8eca-3f0d2c5fa270	true	introspection.token.claim
31eb0e9b-7c19-4a70-8eca-3f0d2c5fa270	true	userinfo.token.claim
31eb0e9b-7c19-4a70-8eca-3f0d2c5fa270	phoneNumberVerified	user.attribute
31eb0e9b-7c19-4a70-8eca-3f0d2c5fa270	true	id.token.claim
31eb0e9b-7c19-4a70-8eca-3f0d2c5fa270	true	access.token.claim
31eb0e9b-7c19-4a70-8eca-3f0d2c5fa270	phone_number_verified	claim.name
31eb0e9b-7c19-4a70-8eca-3f0d2c5fa270	boolean	jsonType.label
7cd517f5-bb49-4e46-917b-8bf4d4d0dc9c	true	introspection.token.claim
7cd517f5-bb49-4e46-917b-8bf4d4d0dc9c	true	userinfo.token.claim
7cd517f5-bb49-4e46-917b-8bf4d4d0dc9c	phoneNumber	user.attribute
7cd517f5-bb49-4e46-917b-8bf4d4d0dc9c	true	id.token.claim
7cd517f5-bb49-4e46-917b-8bf4d4d0dc9c	true	access.token.claim
7cd517f5-bb49-4e46-917b-8bf4d4d0dc9c	phone_number	claim.name
7cd517f5-bb49-4e46-917b-8bf4d4d0dc9c	String	jsonType.label
52a6916b-884e-4a89-ba29-dc24c58d2e46	true	introspection.token.claim
52a6916b-884e-4a89-ba29-dc24c58d2e46	true	multivalued
52a6916b-884e-4a89-ba29-dc24c58d2e46	foo	user.attribute
52a6916b-884e-4a89-ba29-dc24c58d2e46	true	access.token.claim
52a6916b-884e-4a89-ba29-dc24c58d2e46	realm_access.roles	claim.name
52a6916b-884e-4a89-ba29-dc24c58d2e46	String	jsonType.label
536ad4fa-e7d1-41bb-b97b-53118c534cee	true	introspection.token.claim
536ad4fa-e7d1-41bb-b97b-53118c534cee	true	multivalued
536ad4fa-e7d1-41bb-b97b-53118c534cee	foo	user.attribute
536ad4fa-e7d1-41bb-b97b-53118c534cee	true	access.token.claim
536ad4fa-e7d1-41bb-b97b-53118c534cee	resource_access.${client_id}.roles	claim.name
536ad4fa-e7d1-41bb-b97b-53118c534cee	String	jsonType.label
82911b5c-2780-4d4c-b244-c5ff005bbef1	true	introspection.token.claim
82911b5c-2780-4d4c-b244-c5ff005bbef1	true	access.token.claim
ff2ff175-f2ad-40b0-89cc-dd87b7c43ff3	true	introspection.token.claim
ff2ff175-f2ad-40b0-89cc-dd87b7c43ff3	true	access.token.claim
1d4557d4-a854-4fe5-9c02-c198bc0a8b43	true	introspection.token.claim
1d4557d4-a854-4fe5-9c02-c198bc0a8b43	true	multivalued
1d4557d4-a854-4fe5-9c02-c198bc0a8b43	foo	user.attribute
1d4557d4-a854-4fe5-9c02-c198bc0a8b43	true	id.token.claim
1d4557d4-a854-4fe5-9c02-c198bc0a8b43	true	access.token.claim
1d4557d4-a854-4fe5-9c02-c198bc0a8b43	groups	claim.name
1d4557d4-a854-4fe5-9c02-c198bc0a8b43	String	jsonType.label
2dfc3c1c-b494-4fd8-b208-6be977650bf9	true	introspection.token.claim
2dfc3c1c-b494-4fd8-b208-6be977650bf9	true	userinfo.token.claim
2dfc3c1c-b494-4fd8-b208-6be977650bf9	username	user.attribute
2dfc3c1c-b494-4fd8-b208-6be977650bf9	true	id.token.claim
2dfc3c1c-b494-4fd8-b208-6be977650bf9	true	access.token.claim
2dfc3c1c-b494-4fd8-b208-6be977650bf9	upn	claim.name
2dfc3c1c-b494-4fd8-b208-6be977650bf9	String	jsonType.label
ecfc5374-2377-479c-97ea-048771ffbd60	true	introspection.token.claim
ecfc5374-2377-479c-97ea-048771ffbd60	true	id.token.claim
ecfc5374-2377-479c-97ea-048771ffbd60	true	access.token.claim
a980991a-08b7-4a0a-a5f5-827b811e738f	true	introspection.token.claim
a980991a-08b7-4a0a-a5f5-827b811e738f	true	access.token.claim
f5dc314f-ac4c-40ef-8c8d-e621c71119a3	AUTH_TIME	user.session.note
f5dc314f-ac4c-40ef-8c8d-e621c71119a3	true	introspection.token.claim
f5dc314f-ac4c-40ef-8c8d-e621c71119a3	true	id.token.claim
f5dc314f-ac4c-40ef-8c8d-e621c71119a3	true	access.token.claim
f5dc314f-ac4c-40ef-8c8d-e621c71119a3	auth_time	claim.name
f5dc314f-ac4c-40ef-8c8d-e621c71119a3	long	jsonType.label
342b419d-5a38-424d-94a8-175a31a85d70	clientAddress	user.session.note
342b419d-5a38-424d-94a8-175a31a85d70	true	introspection.token.claim
342b419d-5a38-424d-94a8-175a31a85d70	true	id.token.claim
342b419d-5a38-424d-94a8-175a31a85d70	true	access.token.claim
342b419d-5a38-424d-94a8-175a31a85d70	clientAddress	claim.name
342b419d-5a38-424d-94a8-175a31a85d70	String	jsonType.label
73e3a304-bfcf-476e-9301-b375c5c2f93c	client_id	user.session.note
73e3a304-bfcf-476e-9301-b375c5c2f93c	true	introspection.token.claim
73e3a304-bfcf-476e-9301-b375c5c2f93c	true	id.token.claim
73e3a304-bfcf-476e-9301-b375c5c2f93c	true	access.token.claim
73e3a304-bfcf-476e-9301-b375c5c2f93c	client_id	claim.name
73e3a304-bfcf-476e-9301-b375c5c2f93c	String	jsonType.label
cf891011-1414-496d-91be-66ef055899d1	clientHost	user.session.note
cf891011-1414-496d-91be-66ef055899d1	true	introspection.token.claim
cf891011-1414-496d-91be-66ef055899d1	true	id.token.claim
cf891011-1414-496d-91be-66ef055899d1	true	access.token.claim
cf891011-1414-496d-91be-66ef055899d1	clientHost	claim.name
cf891011-1414-496d-91be-66ef055899d1	String	jsonType.label
18829b8a-43e9-4982-8364-8fe07988f2ca	true	introspection.token.claim
18829b8a-43e9-4982-8364-8fe07988f2ca	true	multivalued
18829b8a-43e9-4982-8364-8fe07988f2ca	true	id.token.claim
18829b8a-43e9-4982-8364-8fe07988f2ca	true	access.token.claim
18829b8a-43e9-4982-8364-8fe07988f2ca	organization	claim.name
18829b8a-43e9-4982-8364-8fe07988f2ca	String	jsonType.label
58984c5b-4cf1-44a2-b734-f39e3e4ddfcb	false	single
58984c5b-4cf1-44a2-b734-f39e3e4ddfcb	Basic	attribute.nameformat
58984c5b-4cf1-44a2-b734-f39e3e4ddfcb	Role	attribute.name
1afc9c88-9c87-4040-985c-2026e6b8c2cb	true	introspection.token.claim
1afc9c88-9c87-4040-985c-2026e6b8c2cb	true	userinfo.token.claim
1afc9c88-9c87-4040-985c-2026e6b8c2cb	nickname	user.attribute
1afc9c88-9c87-4040-985c-2026e6b8c2cb	true	id.token.claim
1afc9c88-9c87-4040-985c-2026e6b8c2cb	true	access.token.claim
1afc9c88-9c87-4040-985c-2026e6b8c2cb	nickname	claim.name
1afc9c88-9c87-4040-985c-2026e6b8c2cb	String	jsonType.label
21c5766f-0a16-4794-a6a2-6914473e1b57	true	introspection.token.claim
21c5766f-0a16-4794-a6a2-6914473e1b57	true	userinfo.token.claim
21c5766f-0a16-4794-a6a2-6914473e1b57	true	id.token.claim
21c5766f-0a16-4794-a6a2-6914473e1b57	true	access.token.claim
4e8ffc7b-f23e-49c2-a6a6-7b4c9bfc5173	true	introspection.token.claim
4e8ffc7b-f23e-49c2-a6a6-7b4c9bfc5173	true	userinfo.token.claim
4e8ffc7b-f23e-49c2-a6a6-7b4c9bfc5173	firstName	user.attribute
4e8ffc7b-f23e-49c2-a6a6-7b4c9bfc5173	true	id.token.claim
4e8ffc7b-f23e-49c2-a6a6-7b4c9bfc5173	true	access.token.claim
4e8ffc7b-f23e-49c2-a6a6-7b4c9bfc5173	given_name	claim.name
4e8ffc7b-f23e-49c2-a6a6-7b4c9bfc5173	String	jsonType.label
71d2cb05-f163-4e27-96ce-02bfbb576808	true	introspection.token.claim
71d2cb05-f163-4e27-96ce-02bfbb576808	true	userinfo.token.claim
71d2cb05-f163-4e27-96ce-02bfbb576808	website	user.attribute
71d2cb05-f163-4e27-96ce-02bfbb576808	true	id.token.claim
71d2cb05-f163-4e27-96ce-02bfbb576808	true	access.token.claim
71d2cb05-f163-4e27-96ce-02bfbb576808	website	claim.name
71d2cb05-f163-4e27-96ce-02bfbb576808	String	jsonType.label
7b6c2726-d2f0-444f-8b8a-17dde7d20ff0	true	introspection.token.claim
7b6c2726-d2f0-444f-8b8a-17dde7d20ff0	true	userinfo.token.claim
7b6c2726-d2f0-444f-8b8a-17dde7d20ff0	locale	user.attribute
7b6c2726-d2f0-444f-8b8a-17dde7d20ff0	true	id.token.claim
7b6c2726-d2f0-444f-8b8a-17dde7d20ff0	true	access.token.claim
7b6c2726-d2f0-444f-8b8a-17dde7d20ff0	locale	claim.name
7b6c2726-d2f0-444f-8b8a-17dde7d20ff0	String	jsonType.label
8a122125-9e7e-42ab-b1c7-d04071ffab4c	true	introspection.token.claim
8a122125-9e7e-42ab-b1c7-d04071ffab4c	true	userinfo.token.claim
8a122125-9e7e-42ab-b1c7-d04071ffab4c	profile	user.attribute
8a122125-9e7e-42ab-b1c7-d04071ffab4c	true	id.token.claim
8a122125-9e7e-42ab-b1c7-d04071ffab4c	true	access.token.claim
8a122125-9e7e-42ab-b1c7-d04071ffab4c	profile	claim.name
8a122125-9e7e-42ab-b1c7-d04071ffab4c	String	jsonType.label
998b9f88-7de4-4486-aeac-75e13a575b13	true	introspection.token.claim
998b9f88-7de4-4486-aeac-75e13a575b13	true	userinfo.token.claim
998b9f88-7de4-4486-aeac-75e13a575b13	username	user.attribute
998b9f88-7de4-4486-aeac-75e13a575b13	true	id.token.claim
998b9f88-7de4-4486-aeac-75e13a575b13	true	access.token.claim
998b9f88-7de4-4486-aeac-75e13a575b13	preferred_username	claim.name
998b9f88-7de4-4486-aeac-75e13a575b13	String	jsonType.label
9c70b06d-b159-4929-8f09-c24ac3426296	true	introspection.token.claim
9c70b06d-b159-4929-8f09-c24ac3426296	true	userinfo.token.claim
9c70b06d-b159-4929-8f09-c24ac3426296	picture	user.attribute
9c70b06d-b159-4929-8f09-c24ac3426296	true	id.token.claim
9c70b06d-b159-4929-8f09-c24ac3426296	true	access.token.claim
9c70b06d-b159-4929-8f09-c24ac3426296	picture	claim.name
9c70b06d-b159-4929-8f09-c24ac3426296	String	jsonType.label
9e7678b7-d228-4202-b759-68f2205c31b8	true	introspection.token.claim
9e7678b7-d228-4202-b759-68f2205c31b8	true	userinfo.token.claim
9e7678b7-d228-4202-b759-68f2205c31b8	birthdate	user.attribute
9e7678b7-d228-4202-b759-68f2205c31b8	true	id.token.claim
9e7678b7-d228-4202-b759-68f2205c31b8	true	access.token.claim
9e7678b7-d228-4202-b759-68f2205c31b8	birthdate	claim.name
9e7678b7-d228-4202-b759-68f2205c31b8	String	jsonType.label
c7e74174-16ad-4887-852a-972e7cbf2e60	true	introspection.token.claim
c7e74174-16ad-4887-852a-972e7cbf2e60	true	userinfo.token.claim
c7e74174-16ad-4887-852a-972e7cbf2e60	gender	user.attribute
c7e74174-16ad-4887-852a-972e7cbf2e60	true	id.token.claim
c7e74174-16ad-4887-852a-972e7cbf2e60	true	access.token.claim
c7e74174-16ad-4887-852a-972e7cbf2e60	gender	claim.name
c7e74174-16ad-4887-852a-972e7cbf2e60	String	jsonType.label
cecfb7ae-8fad-4b11-9051-b7faf054a96c	true	introspection.token.claim
cecfb7ae-8fad-4b11-9051-b7faf054a96c	true	userinfo.token.claim
cecfb7ae-8fad-4b11-9051-b7faf054a96c	zoneinfo	user.attribute
cecfb7ae-8fad-4b11-9051-b7faf054a96c	true	id.token.claim
cecfb7ae-8fad-4b11-9051-b7faf054a96c	true	access.token.claim
cecfb7ae-8fad-4b11-9051-b7faf054a96c	zoneinfo	claim.name
cecfb7ae-8fad-4b11-9051-b7faf054a96c	String	jsonType.label
d4df5b77-e03e-4d11-84c4-a5cb3d756050	true	introspection.token.claim
d4df5b77-e03e-4d11-84c4-a5cb3d756050	true	userinfo.token.claim
d4df5b77-e03e-4d11-84c4-a5cb3d756050	middleName	user.attribute
d4df5b77-e03e-4d11-84c4-a5cb3d756050	true	id.token.claim
d4df5b77-e03e-4d11-84c4-a5cb3d756050	true	access.token.claim
d4df5b77-e03e-4d11-84c4-a5cb3d756050	middle_name	claim.name
d4df5b77-e03e-4d11-84c4-a5cb3d756050	String	jsonType.label
e1145f32-78b7-418c-9ef9-8428d2ceacfc	true	introspection.token.claim
e1145f32-78b7-418c-9ef9-8428d2ceacfc	true	userinfo.token.claim
e1145f32-78b7-418c-9ef9-8428d2ceacfc	lastName	user.attribute
e1145f32-78b7-418c-9ef9-8428d2ceacfc	true	id.token.claim
e1145f32-78b7-418c-9ef9-8428d2ceacfc	true	access.token.claim
e1145f32-78b7-418c-9ef9-8428d2ceacfc	family_name	claim.name
e1145f32-78b7-418c-9ef9-8428d2ceacfc	String	jsonType.label
fcfe135e-10a9-4ddf-abf5-06d14e0ce49b	true	introspection.token.claim
fcfe135e-10a9-4ddf-abf5-06d14e0ce49b	true	userinfo.token.claim
fcfe135e-10a9-4ddf-abf5-06d14e0ce49b	updatedAt	user.attribute
fcfe135e-10a9-4ddf-abf5-06d14e0ce49b	true	id.token.claim
fcfe135e-10a9-4ddf-abf5-06d14e0ce49b	true	access.token.claim
fcfe135e-10a9-4ddf-abf5-06d14e0ce49b	updated_at	claim.name
fcfe135e-10a9-4ddf-abf5-06d14e0ce49b	long	jsonType.label
94345099-67e1-44e7-8bfc-98bd69a73098	true	introspection.token.claim
94345099-67e1-44e7-8bfc-98bd69a73098	true	userinfo.token.claim
94345099-67e1-44e7-8bfc-98bd69a73098	emailVerified	user.attribute
94345099-67e1-44e7-8bfc-98bd69a73098	true	id.token.claim
94345099-67e1-44e7-8bfc-98bd69a73098	true	access.token.claim
94345099-67e1-44e7-8bfc-98bd69a73098	email_verified	claim.name
94345099-67e1-44e7-8bfc-98bd69a73098	boolean	jsonType.label
aad570fc-6c36-4987-9c1f-96172631ffb3	true	introspection.token.claim
aad570fc-6c36-4987-9c1f-96172631ffb3	true	userinfo.token.claim
aad570fc-6c36-4987-9c1f-96172631ffb3	email	user.attribute
aad570fc-6c36-4987-9c1f-96172631ffb3	true	id.token.claim
aad570fc-6c36-4987-9c1f-96172631ffb3	true	access.token.claim
aad570fc-6c36-4987-9c1f-96172631ffb3	email	claim.name
aad570fc-6c36-4987-9c1f-96172631ffb3	String	jsonType.label
063938f0-3676-4213-909a-9649ebe95fbd	formatted	user.attribute.formatted
063938f0-3676-4213-909a-9649ebe95fbd	country	user.attribute.country
063938f0-3676-4213-909a-9649ebe95fbd	true	introspection.token.claim
063938f0-3676-4213-909a-9649ebe95fbd	postal_code	user.attribute.postal_code
063938f0-3676-4213-909a-9649ebe95fbd	true	userinfo.token.claim
063938f0-3676-4213-909a-9649ebe95fbd	street	user.attribute.street
063938f0-3676-4213-909a-9649ebe95fbd	true	id.token.claim
063938f0-3676-4213-909a-9649ebe95fbd	region	user.attribute.region
063938f0-3676-4213-909a-9649ebe95fbd	true	access.token.claim
063938f0-3676-4213-909a-9649ebe95fbd	locality	user.attribute.locality
2c5aa5d1-ed2f-438f-9b98-b4d769b9b7d3	true	introspection.token.claim
2c5aa5d1-ed2f-438f-9b98-b4d769b9b7d3	true	userinfo.token.claim
2c5aa5d1-ed2f-438f-9b98-b4d769b9b7d3	phoneNumber	user.attribute
2c5aa5d1-ed2f-438f-9b98-b4d769b9b7d3	true	id.token.claim
2c5aa5d1-ed2f-438f-9b98-b4d769b9b7d3	true	access.token.claim
2c5aa5d1-ed2f-438f-9b98-b4d769b9b7d3	phone_number	claim.name
2c5aa5d1-ed2f-438f-9b98-b4d769b9b7d3	String	jsonType.label
c5ef4e77-9d43-44b7-b2f3-f55ddaaedb58	true	introspection.token.claim
c5ef4e77-9d43-44b7-b2f3-f55ddaaedb58	true	userinfo.token.claim
c5ef4e77-9d43-44b7-b2f3-f55ddaaedb58	phoneNumberVerified	user.attribute
c5ef4e77-9d43-44b7-b2f3-f55ddaaedb58	true	id.token.claim
c5ef4e77-9d43-44b7-b2f3-f55ddaaedb58	true	access.token.claim
c5ef4e77-9d43-44b7-b2f3-f55ddaaedb58	phone_number_verified	claim.name
c5ef4e77-9d43-44b7-b2f3-f55ddaaedb58	boolean	jsonType.label
b492e573-3127-4531-bad6-69c7f4e0037e	true	introspection.token.claim
b492e573-3127-4531-bad6-69c7f4e0037e	true	multivalued
b492e573-3127-4531-bad6-69c7f4e0037e	foo	user.attribute
b492e573-3127-4531-bad6-69c7f4e0037e	true	access.token.claim
b492e573-3127-4531-bad6-69c7f4e0037e	realm_access.roles	claim.name
b492e573-3127-4531-bad6-69c7f4e0037e	String	jsonType.label
c64ce5ad-fc16-41bd-b372-e6780cc1d201	true	introspection.token.claim
c64ce5ad-fc16-41bd-b372-e6780cc1d201	true	access.token.claim
ffb90e0c-a7e0-454d-bd27-1162e7680110	true	introspection.token.claim
ffb90e0c-a7e0-454d-bd27-1162e7680110	true	multivalued
ffb90e0c-a7e0-454d-bd27-1162e7680110	foo	user.attribute
ffb90e0c-a7e0-454d-bd27-1162e7680110	true	access.token.claim
ffb90e0c-a7e0-454d-bd27-1162e7680110	resource_access.${client_id}.roles	claim.name
ffb90e0c-a7e0-454d-bd27-1162e7680110	String	jsonType.label
55c82e62-f173-416c-9657-0e0666200068	true	introspection.token.claim
55c82e62-f173-416c-9657-0e0666200068	true	access.token.claim
459e0803-dc35-4a3b-9716-2c3a55a67000	true	introspection.token.claim
459e0803-dc35-4a3b-9716-2c3a55a67000	true	userinfo.token.claim
459e0803-dc35-4a3b-9716-2c3a55a67000	username	user.attribute
459e0803-dc35-4a3b-9716-2c3a55a67000	true	id.token.claim
459e0803-dc35-4a3b-9716-2c3a55a67000	true	access.token.claim
459e0803-dc35-4a3b-9716-2c3a55a67000	upn	claim.name
459e0803-dc35-4a3b-9716-2c3a55a67000	String	jsonType.label
c5e4b27a-070f-40d5-8a4f-5073838b8eab	true	introspection.token.claim
c5e4b27a-070f-40d5-8a4f-5073838b8eab	true	multivalued
c5e4b27a-070f-40d5-8a4f-5073838b8eab	foo	user.attribute
c5e4b27a-070f-40d5-8a4f-5073838b8eab	true	id.token.claim
c5e4b27a-070f-40d5-8a4f-5073838b8eab	true	access.token.claim
c5e4b27a-070f-40d5-8a4f-5073838b8eab	groups	claim.name
c5e4b27a-070f-40d5-8a4f-5073838b8eab	String	jsonType.label
88f56698-a2e4-4f53-932f-714d790983fc	true	introspection.token.claim
88f56698-a2e4-4f53-932f-714d790983fc	true	id.token.claim
88f56698-a2e4-4f53-932f-714d790983fc	true	access.token.claim
37c10136-8076-4d57-b4fd-f01865126bed	true	introspection.token.claim
37c10136-8076-4d57-b4fd-f01865126bed	true	access.token.claim
d95dedab-014c-45a5-a136-ee3473152e56	AUTH_TIME	user.session.note
d95dedab-014c-45a5-a136-ee3473152e56	true	introspection.token.claim
d95dedab-014c-45a5-a136-ee3473152e56	true	id.token.claim
d95dedab-014c-45a5-a136-ee3473152e56	true	access.token.claim
d95dedab-014c-45a5-a136-ee3473152e56	auth_time	claim.name
d95dedab-014c-45a5-a136-ee3473152e56	long	jsonType.label
6e2638a2-2bb7-42e6-b321-442f9d6a21dd	clientHost	user.session.note
6e2638a2-2bb7-42e6-b321-442f9d6a21dd	true	introspection.token.claim
6e2638a2-2bb7-42e6-b321-442f9d6a21dd	true	id.token.claim
6e2638a2-2bb7-42e6-b321-442f9d6a21dd	true	access.token.claim
6e2638a2-2bb7-42e6-b321-442f9d6a21dd	clientHost	claim.name
6e2638a2-2bb7-42e6-b321-442f9d6a21dd	String	jsonType.label
d80747cc-13f8-4f6b-a508-325a5b3e567a	clientAddress	user.session.note
d80747cc-13f8-4f6b-a508-325a5b3e567a	true	introspection.token.claim
d80747cc-13f8-4f6b-a508-325a5b3e567a	true	id.token.claim
d80747cc-13f8-4f6b-a508-325a5b3e567a	true	access.token.claim
d80747cc-13f8-4f6b-a508-325a5b3e567a	clientAddress	claim.name
d80747cc-13f8-4f6b-a508-325a5b3e567a	String	jsonType.label
dec6eb81-5f38-4e84-b548-9e7f49fd44d9	client_id	user.session.note
dec6eb81-5f38-4e84-b548-9e7f49fd44d9	true	introspection.token.claim
dec6eb81-5f38-4e84-b548-9e7f49fd44d9	true	id.token.claim
dec6eb81-5f38-4e84-b548-9e7f49fd44d9	true	access.token.claim
dec6eb81-5f38-4e84-b548-9e7f49fd44d9	client_id	claim.name
dec6eb81-5f38-4e84-b548-9e7f49fd44d9	String	jsonType.label
4762ad0b-bc54-4aa1-abcd-8c37bdf4c28a	true	introspection.token.claim
4762ad0b-bc54-4aa1-abcd-8c37bdf4c28a	true	multivalued
4762ad0b-bc54-4aa1-abcd-8c37bdf4c28a	true	id.token.claim
4762ad0b-bc54-4aa1-abcd-8c37bdf4c28a	true	access.token.claim
4762ad0b-bc54-4aa1-abcd-8c37bdf4c28a	organization	claim.name
4762ad0b-bc54-4aa1-abcd-8c37bdf4c28a	String	jsonType.label
a3ced95a-3fff-4afc-8309-e74f8213c5a9	true	introspection.token.claim
a3ced95a-3fff-4afc-8309-e74f8213c5a9	true	userinfo.token.claim
a3ced95a-3fff-4afc-8309-e74f8213c5a9	locale	user.attribute
a3ced95a-3fff-4afc-8309-e74f8213c5a9	true	id.token.claim
a3ced95a-3fff-4afc-8309-e74f8213c5a9	true	access.token.claim
a3ced95a-3fff-4afc-8309-e74f8213c5a9	locale	claim.name
a3ced95a-3fff-4afc-8309-e74f8213c5a9	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
41afada5-8096-4d14-92f4-5079d0a42a1d	60	300	300	\N	\N	\N	t	f	0	\N	stock-control-realm	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	39e121f1-0761-4d07-a046-8364e8007116	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	bfb14e97-5a56-496a-adfd-ea5224e9c95e	2d1f828f-bf85-4c12-af8f-3d860d66ffc9	4d6c9170-5adb-40d8-98ac-2a604e8fe5e8	2b036c5b-af75-4b19-8803-8af703408438	cba30767-8fa7-41b4-aa14-24ac8a7e4d54	2592000	f	900	t	f	cdc00aae-71a8-45b2-a5c2-723d8cd42ab6	0	f	0	0	0c352c65-a053-46af-9cb1-2be7e5b9b943
451d845a-b81f-4125-b1b3-f3ec34d3cedb	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	d0d86d4c-3d6a-4c3d-b788-86b7589b4dba	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	f986a234-9c3d-4051-b136-67da440c527b	a461e5c1-7ad1-4810-8a5a-905a8d19be0b	79d4859f-0f2c-4543-98c1-77549dc02f1d	f192c125-2769-4a0c-94cf-dff08fd451a6	7fde9135-8033-4736-a43f-a78c024b2125	2592000	f	900	t	f	4ccec81c-90d7-4967-bb8f-59cdef8c890a	0	f	0	0	0188e131-5704-4cc9-92db-d30de3bab1b4
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	451d845a-b81f-4125-b1b3-f3ec34d3cedb	
_browser_header.xContentTypeOptions	451d845a-b81f-4125-b1b3-f3ec34d3cedb	nosniff
_browser_header.referrerPolicy	451d845a-b81f-4125-b1b3-f3ec34d3cedb	no-referrer
_browser_header.xRobotsTag	451d845a-b81f-4125-b1b3-f3ec34d3cedb	none
_browser_header.xFrameOptions	451d845a-b81f-4125-b1b3-f3ec34d3cedb	SAMEORIGIN
_browser_header.contentSecurityPolicy	451d845a-b81f-4125-b1b3-f3ec34d3cedb	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	451d845a-b81f-4125-b1b3-f3ec34d3cedb	max-age=31536000; includeSubDomains
bruteForceProtected	451d845a-b81f-4125-b1b3-f3ec34d3cedb	false
permanentLockout	451d845a-b81f-4125-b1b3-f3ec34d3cedb	false
maxTemporaryLockouts	451d845a-b81f-4125-b1b3-f3ec34d3cedb	0
bruteForceStrategy	451d845a-b81f-4125-b1b3-f3ec34d3cedb	MULTIPLE
maxFailureWaitSeconds	451d845a-b81f-4125-b1b3-f3ec34d3cedb	900
minimumQuickLoginWaitSeconds	451d845a-b81f-4125-b1b3-f3ec34d3cedb	60
waitIncrementSeconds	451d845a-b81f-4125-b1b3-f3ec34d3cedb	60
quickLoginCheckMilliSeconds	451d845a-b81f-4125-b1b3-f3ec34d3cedb	1000
maxDeltaTimeSeconds	451d845a-b81f-4125-b1b3-f3ec34d3cedb	43200
failureFactor	451d845a-b81f-4125-b1b3-f3ec34d3cedb	30
realmReusableOtpCode	451d845a-b81f-4125-b1b3-f3ec34d3cedb	false
firstBrokerLoginFlowId	451d845a-b81f-4125-b1b3-f3ec34d3cedb	e694f4d3-d830-4546-8f9e-181e03e54c95
displayName	451d845a-b81f-4125-b1b3-f3ec34d3cedb	Keycloak
displayNameHtml	451d845a-b81f-4125-b1b3-f3ec34d3cedb	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	451d845a-b81f-4125-b1b3-f3ec34d3cedb	RS256
offlineSessionMaxLifespanEnabled	451d845a-b81f-4125-b1b3-f3ec34d3cedb	false
offlineSessionMaxLifespan	451d845a-b81f-4125-b1b3-f3ec34d3cedb	5184000
_browser_header.contentSecurityPolicyReportOnly	41afada5-8096-4d14-92f4-5079d0a42a1d	
_browser_header.xContentTypeOptions	41afada5-8096-4d14-92f4-5079d0a42a1d	nosniff
_browser_header.referrerPolicy	41afada5-8096-4d14-92f4-5079d0a42a1d	no-referrer
_browser_header.xRobotsTag	41afada5-8096-4d14-92f4-5079d0a42a1d	none
_browser_header.strictTransportSecurity	41afada5-8096-4d14-92f4-5079d0a42a1d	max-age=31536000; includeSubDomains
bruteForceProtected	41afada5-8096-4d14-92f4-5079d0a42a1d	false
permanentLockout	41afada5-8096-4d14-92f4-5079d0a42a1d	false
maxTemporaryLockouts	41afada5-8096-4d14-92f4-5079d0a42a1d	0
bruteForceStrategy	41afada5-8096-4d14-92f4-5079d0a42a1d	MULTIPLE
maxFailureWaitSeconds	41afada5-8096-4d14-92f4-5079d0a42a1d	900
minimumQuickLoginWaitSeconds	41afada5-8096-4d14-92f4-5079d0a42a1d	60
waitIncrementSeconds	41afada5-8096-4d14-92f4-5079d0a42a1d	60
quickLoginCheckMilliSeconds	41afada5-8096-4d14-92f4-5079d0a42a1d	1000
maxDeltaTimeSeconds	41afada5-8096-4d14-92f4-5079d0a42a1d	43200
failureFactor	41afada5-8096-4d14-92f4-5079d0a42a1d	30
realmReusableOtpCode	41afada5-8096-4d14-92f4-5079d0a42a1d	false
defaultSignatureAlgorithm	41afada5-8096-4d14-92f4-5079d0a42a1d	RS256
offlineSessionMaxLifespanEnabled	41afada5-8096-4d14-92f4-5079d0a42a1d	false
offlineSessionMaxLifespan	41afada5-8096-4d14-92f4-5079d0a42a1d	5184000
actionTokenGeneratedByAdminLifespan	41afada5-8096-4d14-92f4-5079d0a42a1d	43200
actionTokenGeneratedByUserLifespan	41afada5-8096-4d14-92f4-5079d0a42a1d	300
oauth2DeviceCodeLifespan	41afada5-8096-4d14-92f4-5079d0a42a1d	600
oauth2DevicePollingInterval	41afada5-8096-4d14-92f4-5079d0a42a1d	5
webAuthnPolicyRpEntityName	41afada5-8096-4d14-92f4-5079d0a42a1d	keycloak
webAuthnPolicySignatureAlgorithms	41afada5-8096-4d14-92f4-5079d0a42a1d	ES256,RS256
webAuthnPolicyRpId	41afada5-8096-4d14-92f4-5079d0a42a1d	
webAuthnPolicyAttestationConveyancePreference	41afada5-8096-4d14-92f4-5079d0a42a1d	not specified
webAuthnPolicyAuthenticatorAttachment	41afada5-8096-4d14-92f4-5079d0a42a1d	not specified
webAuthnPolicyRequireResidentKey	41afada5-8096-4d14-92f4-5079d0a42a1d	not specified
webAuthnPolicyUserVerificationRequirement	41afada5-8096-4d14-92f4-5079d0a42a1d	not specified
webAuthnPolicyCreateTimeout	41afada5-8096-4d14-92f4-5079d0a42a1d	0
webAuthnPolicyAvoidSameAuthenticatorRegister	41afada5-8096-4d14-92f4-5079d0a42a1d	false
webAuthnPolicyRpEntityNamePasswordless	41afada5-8096-4d14-92f4-5079d0a42a1d	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	41afada5-8096-4d14-92f4-5079d0a42a1d	ES256,RS256
webAuthnPolicyRpIdPasswordless	41afada5-8096-4d14-92f4-5079d0a42a1d	
webAuthnPolicyAttestationConveyancePreferencePasswordless	41afada5-8096-4d14-92f4-5079d0a42a1d	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	41afada5-8096-4d14-92f4-5079d0a42a1d	not specified
webAuthnPolicyRequireResidentKeyPasswordless	41afada5-8096-4d14-92f4-5079d0a42a1d	Yes
webAuthnPolicyUserVerificationRequirementPasswordless	41afada5-8096-4d14-92f4-5079d0a42a1d	required
webAuthnPolicyCreateTimeoutPasswordless	41afada5-8096-4d14-92f4-5079d0a42a1d	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	41afada5-8096-4d14-92f4-5079d0a42a1d	false
cibaBackchannelTokenDeliveryMode	41afada5-8096-4d14-92f4-5079d0a42a1d	poll
cibaExpiresIn	41afada5-8096-4d14-92f4-5079d0a42a1d	120
cibaInterval	41afada5-8096-4d14-92f4-5079d0a42a1d	5
cibaAuthRequestedUserHint	41afada5-8096-4d14-92f4-5079d0a42a1d	login_hint
parRequestUriLifespan	41afada5-8096-4d14-92f4-5079d0a42a1d	60
firstBrokerLoginFlowId	41afada5-8096-4d14-92f4-5079d0a42a1d	a1fe65de-3f0e-4dd6-aeef-37c6a44cc0a3
organizationsEnabled	41afada5-8096-4d14-92f4-5079d0a42a1d	false
adminPermissionsEnabled	41afada5-8096-4d14-92f4-5079d0a42a1d	false
verifiableCredentialsEnabled	41afada5-8096-4d14-92f4-5079d0a42a1d	false
clientSessionIdleTimeout	41afada5-8096-4d14-92f4-5079d0a42a1d	0
clientSessionMaxLifespan	41afada5-8096-4d14-92f4-5079d0a42a1d	0
clientOfflineSessionIdleTimeout	41afada5-8096-4d14-92f4-5079d0a42a1d	0
clientOfflineSessionMaxLifespan	41afada5-8096-4d14-92f4-5079d0a42a1d	0
client-policies.profiles	41afada5-8096-4d14-92f4-5079d0a42a1d	{"profiles":[]}
client-policies.policies	41afada5-8096-4d14-92f4-5079d0a42a1d	{"policies":[]}
_browser_header.contentSecurityPolicy	41afada5-8096-4d14-92f4-5079d0a42a1d	frame-ancestors 'self' http://localhost:4200;
_browser_header.xFrameOptions	41afada5-8096-4d14-92f4-5079d0a42a1d	ALLOW-FROM http://localhost:4200
frontendUrl	41afada5-8096-4d14-92f4-5079d0a42a1d	
saml.signature.algorithm	41afada5-8096-4d14-92f4-5079d0a42a1d	
acr.loa.map	41afada5-8096-4d14-92f4-5079d0a42a1d	{}
displayNameHtml	41afada5-8096-4d14-92f4-5079d0a42a1d	
displayName	41afada5-8096-4d14-92f4-5079d0a42a1d	Stock Control System
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
451d845a-b81f-4125-b1b3-f3ec34d3cedb	jboss-logging
41afada5-8096-4d14-92f4-5079d0a42a1d	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	451d845a-b81f-4125-b1b3-f3ec34d3cedb
password	password	t	t	41afada5-8096-4d14-92f4-5079d0a42a1d
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.redirect_uris (client_id, value) FROM stdin;
aa93bd47-f839-4238-b0b0-fd0b9191ee08	/realms/master/account/*
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	/realms/master/account/*
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	/admin/master/console/*
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	http://localhost:4200/*
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	/admin/stock-control-realm/console/*
bf1cb08b-39f9-4a02-9523-7d5ec27dfa72	/realms/stock-control-realm/account/*
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	/realms/stock-control-realm/account/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
0c497ed3-8e1d-48ae-86a6-e4edd41dafb6	VERIFY_EMAIL	Verify Email	451d845a-b81f-4125-b1b3-f3ec34d3cedb	t	f	VERIFY_EMAIL	50
d0a0d449-cc71-4735-b6ed-7c7c207a2634	UPDATE_PROFILE	Update Profile	451d845a-b81f-4125-b1b3-f3ec34d3cedb	t	f	UPDATE_PROFILE	40
a6754c9f-00bd-4848-b1e2-996db099e977	CONFIGURE_TOTP	Configure OTP	451d845a-b81f-4125-b1b3-f3ec34d3cedb	t	f	CONFIGURE_TOTP	10
b4dcfc2b-d39c-4f63-8923-26ad6e11695b	UPDATE_PASSWORD	Update Password	451d845a-b81f-4125-b1b3-f3ec34d3cedb	t	f	UPDATE_PASSWORD	30
dd8f861f-b614-4343-a929-a2a2102a445d	TERMS_AND_CONDITIONS	Terms and Conditions	451d845a-b81f-4125-b1b3-f3ec34d3cedb	f	f	TERMS_AND_CONDITIONS	20
b01ee435-02f0-4731-ab98-4f32a9326815	delete_account	Delete Account	451d845a-b81f-4125-b1b3-f3ec34d3cedb	f	f	delete_account	60
a09d800a-a506-4bd9-bece-9f1dd3d24061	delete_credential	Delete Credential	451d845a-b81f-4125-b1b3-f3ec34d3cedb	t	f	delete_credential	110
28885329-07c5-4e03-94be-6934863c1533	update_user_locale	Update User Locale	451d845a-b81f-4125-b1b3-f3ec34d3cedb	t	f	update_user_locale	1000
dbc3fc83-af19-4cf4-a301-480f158fb9e4	UPDATE_EMAIL	Update Email	451d845a-b81f-4125-b1b3-f3ec34d3cedb	f	f	UPDATE_EMAIL	70
5cb195ef-136e-4e78-b054-b6d94f6aa567	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	451d845a-b81f-4125-b1b3-f3ec34d3cedb	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	130
11777783-4823-4f7f-bec1-1cbef9990030	webauthn-register	Webauthn Register	451d845a-b81f-4125-b1b3-f3ec34d3cedb	t	f	webauthn-register	80
12ad9dbd-ae90-4fcd-a5f1-37f2570937ad	webauthn-register-passwordless	Webauthn Register Passwordless	451d845a-b81f-4125-b1b3-f3ec34d3cedb	t	f	webauthn-register-passwordless	90
08d7bedb-915c-4f34-8559-c9def858d0d5	VERIFY_PROFILE	Verify Profile	451d845a-b81f-4125-b1b3-f3ec34d3cedb	t	f	VERIFY_PROFILE	100
f58c0cc3-2322-4caa-b297-b56146de5deb	idp_link	Linking Identity Provider	451d845a-b81f-4125-b1b3-f3ec34d3cedb	t	f	idp_link	120
b106e021-591b-4890-887f-d7b5e4074991	VERIFY_EMAIL	Verify Email	41afada5-8096-4d14-92f4-5079d0a42a1d	t	f	VERIFY_EMAIL	50
58905fdf-3db5-4608-907d-64a7a3443374	UPDATE_PROFILE	Update Profile	41afada5-8096-4d14-92f4-5079d0a42a1d	t	f	UPDATE_PROFILE	40
40b1d244-fab3-44a7-854e-111093fb59b6	CONFIGURE_TOTP	Configure OTP	41afada5-8096-4d14-92f4-5079d0a42a1d	t	f	CONFIGURE_TOTP	10
63709f25-ba1b-4cad-acd5-197485f43e55	UPDATE_PASSWORD	Update Password	41afada5-8096-4d14-92f4-5079d0a42a1d	t	f	UPDATE_PASSWORD	30
72b242fe-1d19-42ec-95b3-be1836c394f7	TERMS_AND_CONDITIONS	Terms and Conditions	41afada5-8096-4d14-92f4-5079d0a42a1d	f	f	TERMS_AND_CONDITIONS	20
2cf5cfa5-2ed3-45d4-96b1-ac368b63eb4a	delete_account	Delete Account	41afada5-8096-4d14-92f4-5079d0a42a1d	f	f	delete_account	60
af8cfc8f-f84e-4e67-9baf-b3ce6f801c30	delete_credential	Delete Credential	41afada5-8096-4d14-92f4-5079d0a42a1d	t	f	delete_credential	110
2163dd73-90a2-4be5-a562-b1443d4f143d	update_user_locale	Update User Locale	41afada5-8096-4d14-92f4-5079d0a42a1d	t	f	update_user_locale	1000
c90d43aa-f1ec-437f-b866-4945283059ca	UPDATE_EMAIL	Update Email	41afada5-8096-4d14-92f4-5079d0a42a1d	f	f	UPDATE_EMAIL	70
134730ea-cf91-4eeb-936e-684a8314440e	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	41afada5-8096-4d14-92f4-5079d0a42a1d	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	130
b9591866-3059-48db-882b-2860f8b9f821	webauthn-register	Webauthn Register	41afada5-8096-4d14-92f4-5079d0a42a1d	t	f	webauthn-register	80
b56f1e4a-e860-4774-af7f-87f551822ef1	webauthn-register-passwordless	Webauthn Register Passwordless	41afada5-8096-4d14-92f4-5079d0a42a1d	t	f	webauthn-register-passwordless	90
c690e6c6-8ed3-40c7-b544-00bf06553ee4	VERIFY_PROFILE	Verify Profile	41afada5-8096-4d14-92f4-5079d0a42a1d	t	f	VERIFY_PROFILE	100
3463a487-ff8f-44f2-a283-3b86a8e5434f	idp_link	Linking Identity Provider	41afada5-8096-4d14-92f4-5079d0a42a1d	t	f	idp_link	120
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	ba47cbd3-5ce9-4eae-9c4c-08b4994b64af
1ef46b6e-df4e-433b-afcd-a1c1f7dbff23	5e7859b5-58f0-46a6-ad1c-488a3d20480b
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	28d741ec-c313-43ef-ba5f-8602959e9787
ee1ad023-81cc-4905-86cc-3bb0a80bb7da	530ab8c0-acf9-4e9d-ae0a-87dc569a165d
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: server_config; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.server_config (server_config_key, value, version) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	949b1377-a910-4a0c-975b-c730c862f502	b19539cb-92b4-43ad-ab43-d2aeb116dd2c	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
949b1377-a910-4a0c-975b-c730c862f502	\N	1e33dd56-a048-4c22-b7d6-363527dd9ceb	f	t	\N	\N	\N	451d845a-b81f-4125-b1b3-f3ec34d3cedb	admin	1772682388658	\N	0
753f9009-b472-4566-9405-a4e932dcfe6c	teste@teste.com	teste@teste.com	f	t	\N	Usuario	Teste	41afada5-8096-4d14-92f4-5079d0a42a1d	teste	1772683432146	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
0188e131-5704-4cc9-92db-d30de3bab1b4	949b1377-a910-4a0c-975b-c730c862f502
51ab19a8-a21d-4a78-aca0-5ca7146addb4	949b1377-a910-4a0c-975b-c730c862f502
0c352c65-a053-46af-9cb1-2be7e5b9b943	753f9009-b472-4566-9405-a4e932dcfe6c
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.web_origins (client_id, value) FROM stdin;
f0f68f03-f62d-42e3-8a6a-0b87849b4a9a	+
a60452b1-4bd0-44bd-9ce8-b77b6a3f1ef9	+
c384aae9-4d5b-487b-b9ef-977a6c03e2c7	http://localhost:4200
\.


--
-- Data for Name: workflow_state; Type: TABLE DATA; Schema: public; Owner: keycloak_user
--

COPY public.workflow_state (execution_id, resource_id, workflow_id, resource_type, scheduled_step_id, scheduled_step_timestamp) FROM stdin;
\.


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: server_config SERVER_CONFIG_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.server_config
    ADD CONSTRAINT "SERVER_CONFIG_pkey" PRIMARY KEY (server_config_key);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: org_invitation constraint_org_invitation; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.org_invitation
    ADD CONSTRAINT constraint_org_invitation PRIMARY KEY (id);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: workflow_state pk_workflow_state; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.workflow_state
    ADD CONSTRAINT pk_workflow_state PRIMARY KEY (execution_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: migration_model uk_migration_update_time; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_update_time UNIQUE (update_time);


--
-- Name: migration_model uk_migration_version; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_version UNIQUE (version);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org_invitation uk_org_invitation_email; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.org_invitation
    ADD CONSTRAINT uk_org_invitation_email UNIQUE (organization_id, email);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: workflow_state uq_workflow_resource; Type: CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.workflow_state
    ADD CONSTRAINT uq_workflow_resource UNIQUE (workflow_id, resource_id);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_broker_link_identity_provider; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_broker_link_identity_provider ON public.broker_link USING btree (realm_id, identity_provider, broker_user_id);


--
-- Name: idx_broker_link_user_id; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_broker_link_user_id ON public.broker_link USING btree (user_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_entity_user_id_type; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_event_entity_user_id_type ON public.event_entity USING btree (user_id, type, event_time);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_by_client; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_offline_css_by_client ON public.offline_client_session USING btree (client_id, offline_flag) WHERE ((client_id)::text <> 'external'::text);


--
-- Name: idx_offline_css_by_client_storage_provider; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_offline_css_by_client_storage_provider ON public.offline_client_session USING btree (client_storage_provider, external_client_id, offline_flag) WHERE ((client_storage_provider)::text <> 'internal'::text);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_org_invitation_email; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_org_invitation_email ON public.org_invitation USING btree (email);


--
-- Name: idx_org_invitation_expires; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_org_invitation_expires ON public.org_invitation USING btree (expires_at);


--
-- Name: idx_org_invitation_org_id; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_org_invitation_org_id ON public.org_invitation USING btree (organization_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_user_session_expiration_created; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_user_session_expiration_created ON public.offline_user_session USING btree (realm_id, offline_flag, remember_me, created_on, user_session_id, user_id);


--
-- Name: idx_user_session_expiration_last_refresh; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_user_session_expiration_last_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, remember_me, last_session_refresh, user_session_id, user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: idx_workflow_state_provider; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_workflow_state_provider ON public.workflow_state USING btree (resource_id);


--
-- Name: idx_workflow_state_step; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX idx_workflow_state_step ON public.workflow_state USING btree (workflow_id, scheduled_step_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak_user
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: org_invitation fk_org_invitation_org; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.org_invitation
    ADD CONSTRAINT fk_org_invitation_org FOREIGN KEY (organization_id) REFERENCES public.org(id) ON DELETE CASCADE;


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_user
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

