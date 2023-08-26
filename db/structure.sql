SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: enrollment_appointment_pass; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enrollment_appointment_pass AS ENUM (
    'graduate',
    'priority',
    'first',
    'second'
);


--
-- Name: enrollment_appointment_standing; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enrollment_appointment_standing AS ENUM (
    'graduating_senior',
    'almost_graduating_senior',
    'new',
    'readmitted',
    'visiting',
    'senior',
    'junior',
    'sophomore',
    'freshman',
    'joint_graduate',
    'graduate'
);


--
-- Name: final_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.final_type AS ENUM (
    'none',
    '10th',
    'finals'
);


--
-- Name: grade_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.grade_type AS ENUM (
    'A+',
    'A',
    'A-',
    'B+',
    'B',
    'B-',
    'C+',
    'C',
    'C-',
    'D+',
    'D',
    'D-',
    'F',
    'P',
    'NP'
);


--
-- Name: review_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.review_status AS ENUM (
    'pending',
    'approved',
    'rejected'
);


--
-- Name: section_format; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.section_format AS ENUM (
    'ACT',
    'CLI',
    'DIS',
    'FLD',
    'LAB',
    'LEC',
    'REC',
    'RGP',
    'SEM',
    'STU',
    'TUT'
);


--
-- Name: summer_session; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.summer_session AS ENUM (
    'A',
    'B',
    'C',
    'D',
    'V'
);


--
-- Name: weekly_time_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.weekly_time_type AS ENUM (
    '0-5',
    '5-10',
    '10-15',
    '15-20',
    '20+'
);


--
-- Name: is_graduate(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.is_graduate(num character varying) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
    BEGIN
        RETURN (num SIMILAR TO '%[2-9][0-9][0-9]%');
    END
$$;


--
-- Name: strposrev(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.strposrev(instring text, insubstring text) RETURNS integer
    LANGUAGE plpgsql IMMUTABLE STRICT COST 4
    AS $$
DECLARE result INTEGER;
BEGIN
    IF strpos(instring, insubstring) = 0 THEN
        -- no match
        result:=0;
    ELSEIF length(insubstring)=1 THEN
        -- add one to get the correct position from the left.
        result:= 1 + length(instring) - strpos(reverse(instring), insubstring);
    ELSE
        -- add two minus the legth of the search string
        result:= 2 + length(instring)- length(insubstring) - strpos(reverse(instring), reverse(insubstring));
    END IF;
    RETURN result;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ahoy_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ahoy_events (
    id bigint NOT NULL,
    visit_id bigint,
    user_id bigint,
    name character varying,
    properties jsonb,
    "time" timestamp without time zone
);


--
-- Name: ahoy_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ahoy_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ahoy_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ahoy_events_id_seq OWNED BY public.ahoy_events.id;


--
-- Name: ahoy_visits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ahoy_visits (
    id bigint NOT NULL,
    visit_token character varying,
    visitor_token character varying,
    user_id bigint,
    ip character varying,
    user_agent text,
    referrer text,
    referring_domain character varying,
    landing_page text,
    browser character varying,
    os character varying,
    device_type character varying,
    country character varying,
    region character varying,
    city character varying,
    latitude double precision,
    longitude double precision,
    utm_source character varying,
    utm_medium character varying,
    utm_term character varying,
    utm_content character varying,
    utm_campaign character varying,
    app_version character varying,
    os_version character varying,
    platform character varying,
    started_at timestamp without time zone
);


--
-- Name: ahoy_visits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ahoy_visits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ahoy_visits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ahoy_visits_id_seq OWNED BY public.ahoy_visits.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: blazer_audits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blazer_audits (
    id bigint NOT NULL,
    user_id bigint,
    query_id bigint,
    statement text,
    data_source character varying,
    created_at timestamp without time zone
);


--
-- Name: blazer_audits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blazer_audits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blazer_audits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blazer_audits_id_seq OWNED BY public.blazer_audits.id;


--
-- Name: blazer_checks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blazer_checks (
    id bigint NOT NULL,
    creator_id bigint,
    query_id bigint,
    state character varying,
    schedule character varying,
    emails text,
    slack_channels text,
    check_type character varying,
    message text,
    last_run_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: blazer_checks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blazer_checks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blazer_checks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blazer_checks_id_seq OWNED BY public.blazer_checks.id;


--
-- Name: blazer_dashboard_queries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blazer_dashboard_queries (
    id bigint NOT NULL,
    dashboard_id bigint,
    query_id bigint,
    "position" integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: blazer_dashboard_queries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blazer_dashboard_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blazer_dashboard_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blazer_dashboard_queries_id_seq OWNED BY public.blazer_dashboard_queries.id;


--
-- Name: blazer_dashboards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blazer_dashboards (
    id bigint NOT NULL,
    creator_id bigint,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: blazer_dashboards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blazer_dashboards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blazer_dashboards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blazer_dashboards_id_seq OWNED BY public.blazer_dashboards.id;


--
-- Name: blazer_queries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blazer_queries (
    id bigint NOT NULL,
    creator_id bigint,
    name character varying,
    description text,
    statement text,
    data_source character varying,
    status character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: blazer_queries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blazer_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blazer_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blazer_queries_id_seq OWNED BY public.blazer_queries.id;


--
-- Name: course_section_indices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_section_indices (
    id bigint NOT NULL,
    course_id bigint NOT NULL,
    term_id bigint NOT NULL,
    indices text[] DEFAULT '{}'::text[] NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: course_section_indices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_section_indices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_section_indices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_section_indices_id_seq OWNED BY public.course_section_indices.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.courses (
    id bigint NOT NULL,
    title character varying NOT NULL,
    number character varying NOT NULL,
    subject_area_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    description character varying,
    units character varying,
    superseding_course_id bigint
);


--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;


--
-- Name: courses_terms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.courses_terms (
    course_id bigint NOT NULL,
    term_id bigint NOT NULL
);


--
-- Name: enrollment_appointments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enrollment_appointments (
    id bigint NOT NULL,
    term_id bigint NOT NULL,
    pass public.enrollment_appointment_pass NOT NULL,
    standing public.enrollment_appointment_standing,
    first timestamp without time zone NOT NULL,
    last timestamp without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: enrollment_appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enrollment_appointments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enrollment_appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enrollment_appointments_id_seq OWNED BY public.enrollment_appointments.id;


--
-- Name: enrollment_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enrollment_data (
    id bigint NOT NULL,
    section_id bigint NOT NULL,
    enrollment_status character varying NOT NULL,
    enrollment_count integer NOT NULL,
    enrollment_capacity integer NOT NULL,
    waitlist_status character varying NOT NULL,
    waitlist_count integer NOT NULL,
    waitlist_capacity integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: enrollment_data_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enrollment_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enrollment_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enrollment_data_id_seq OWNED BY public.enrollment_data.id;


--
-- Name: grade_distributions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.grade_distributions (
    id bigint NOT NULL,
    section_id bigint,
    percent_a_plus double precision DEFAULT 0.0 NOT NULL,
    percent_a double precision DEFAULT 0.0 NOT NULL,
    percent_a_minus double precision DEFAULT 0.0 NOT NULL,
    percent_b_plus double precision DEFAULT 0.0 NOT NULL,
    percent_b double precision DEFAULT 0.0 NOT NULL,
    percent_b_minus double precision DEFAULT 0.0 NOT NULL,
    percent_c_plus double precision DEFAULT 0.0 NOT NULL,
    percent_c double precision DEFAULT 0.0 NOT NULL,
    percent_c_minus double precision DEFAULT 0.0 NOT NULL,
    percent_d_plus double precision DEFAULT 0.0 NOT NULL,
    percent_d double precision DEFAULT 0.0 NOT NULL,
    percent_d_minus double precision DEFAULT 0.0 NOT NULL,
    percent_f double precision DEFAULT 0.0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: grade_distributions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.grade_distributions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: grade_distributions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.grade_distributions_id_seq OWNED BY public.grade_distributions.id;


--
-- Name: instructors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.instructors (
    id bigint NOT NULL,
    first_names character varying[] DEFAULT '{}'::character varying[],
    last_names character varying[] DEFAULT '{}'::character varying[],
    preferred_label character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    registrar_listing character varying[]
);


--
-- Name: instructors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.instructors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: instructors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.instructors_id_seq OWNED BY public.instructors.id;


--
-- Name: mailkick_subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mailkick_subscriptions (
    id bigint NOT NULL,
    subscriber_type character varying,
    subscriber_id bigint,
    list character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: mailkick_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mailkick_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mailkick_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mailkick_subscriptions_id_seq OWNED BY public.mailkick_subscriptions.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    recipient_type character varying NOT NULL,
    recipient_id bigint NOT NULL,
    type character varying NOT NULL,
    params jsonb,
    read_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: pay_charges; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pay_charges (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    subscription_id bigint,
    processor_id character varying NOT NULL,
    amount integer NOT NULL,
    currency character varying,
    application_fee_amount integer,
    amount_refunded integer,
    metadata jsonb,
    data jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: pay_charges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pay_charges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pay_charges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pay_charges_id_seq OWNED BY public.pay_charges.id;


--
-- Name: pay_customers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pay_customers (
    id bigint NOT NULL,
    owner_type character varying,
    owner_id bigint,
    processor character varying NOT NULL,
    processor_id character varying,
    "default" boolean,
    data jsonb,
    deleted_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: pay_customers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pay_customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pay_customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pay_customers_id_seq OWNED BY public.pay_customers.id;


--
-- Name: pay_merchants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pay_merchants (
    id bigint NOT NULL,
    owner_type character varying,
    owner_id bigint,
    processor character varying NOT NULL,
    processor_id character varying,
    "default" boolean,
    data jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: pay_merchants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pay_merchants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pay_merchants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pay_merchants_id_seq OWNED BY public.pay_merchants.id;


--
-- Name: pay_payment_methods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pay_payment_methods (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    processor_id character varying NOT NULL,
    "default" boolean,
    type character varying,
    data jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: pay_payment_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pay_payment_methods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pay_payment_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pay_payment_methods_id_seq OWNED BY public.pay_payment_methods.id;


--
-- Name: pay_subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pay_subscriptions (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    name character varying NOT NULL,
    processor_id character varying NOT NULL,
    processor_plan character varying NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    status character varying NOT NULL,
    trial_ends_at timestamp without time zone,
    ends_at timestamp without time zone,
    application_fee_percent numeric(8,2),
    metadata jsonb,
    data jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: pay_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pay_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pay_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pay_subscriptions_id_seq OWNED BY public.pay_subscriptions.id;


--
-- Name: pay_webhooks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pay_webhooks (
    id bigint NOT NULL,
    processor character varying,
    event_type character varying,
    event jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: pay_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pay_webhooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pay_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pay_webhooks_id_seq OWNED BY public.pay_webhooks.id;


--
-- Name: relationships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.relationships (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    section_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    notify boolean DEFAULT false NOT NULL
);


--
-- Name: relationships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.relationships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.relationships_id_seq OWNED BY public.relationships.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    organization integer,
    clarity integer,
    overall integer,
    comments text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    has_group_project boolean,
    requires_attendance boolean,
    midterm_count integer,
    final public.final_type,
    reccomend_textbook boolean,
    grade public.grade_type,
    weekly_time public.weekly_time_type,
    offers_extra_credit boolean,
    hidden boolean DEFAULT false NOT NULL,
    relationship_id bigint,
    status public.review_status DEFAULT 'pending'::public.review_status NOT NULL,
    first_approved_at timestamp(6) without time zone DEFAULT NULL::timestamp without time zone
);


--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: searchjoy_searches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.searchjoy_searches (
    id bigint NOT NULL,
    user_id bigint,
    search_type character varying,
    query character varying,
    normalized_query character varying,
    results_count integer,
    created_at timestamp without time zone,
    convertable_type character varying,
    convertable_id bigint,
    converted_at timestamp without time zone
);


--
-- Name: searchjoy_searches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.searchjoy_searches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: searchjoy_searches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.searchjoy_searches_id_seq OWNED BY public.searchjoy_searches.id;


--
-- Name: sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sections (
    id bigint NOT NULL,
    course_id bigint NOT NULL,
    term_id bigint NOT NULL,
    registrar_id character varying NOT NULL,
    days character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    times character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    locations character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    registrar_instructors text[] DEFAULT '{}'::text[] NOT NULL,
    enrollment_status character varying NOT NULL,
    enrollment_count integer NOT NULL,
    enrollment_capacity integer NOT NULL,
    waitlist_status character varying NOT NULL,
    waitlist_count integer NOT NULL,
    waitlist_capacity integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    format public.section_format,
    index integer,
    website character varying,
    final_start timestamp without time zone,
    final_end timestamp without time zone,
    summer_session public.summer_session,
    summer_duration_weeks integer,
    instructor_id bigint,
    should_update_instructor boolean DEFAULT true NOT NULL,
    asucla_id character varying
);


--
-- Name: sections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sections_id_seq OWNED BY public.sections.id;


--
-- Name: sections_textbooks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sections_textbooks (
    textbook_id bigint NOT NULL,
    section_id bigint NOT NULL
);


--
-- Name: subject_areas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subject_areas (
    id bigint NOT NULL,
    name character varying NOT NULL,
    code character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    superseding_subject_area_id bigint
);


--
-- Name: subject_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.subject_areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: subject_areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.subject_areas_id_seq OWNED BY public.subject_areas.id;


--
-- Name: terms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.terms (
    id bigint NOT NULL,
    term character varying(3) NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    start_date date,
    end_date date,
    session_a_start date,
    session_b_start date,
    session_c_start date,
    session_d_start date
);


--
-- Name: terms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.terms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.terms_id_seq OWNED BY public.terms.id;


--
-- Name: textbooks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.textbooks (
    id bigint NOT NULL,
    isbn character varying NOT NULL,
    title character varying NOT NULL,
    author character varying,
    is_required boolean,
    edition smallint,
    copyright_year character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: textbooks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.textbooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: textbooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.textbooks_id_seq OWNED BY public.textbooks.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    admin boolean DEFAULT false NOT NULL,
    provider character varying,
    uid character varying,
    remember_token character varying,
    notification_token_count smallint DEFAULT 2 NOT NULL,
    phone character varying,
    beta_tester boolean DEFAULT false NOT NULL,
    referral_code character varying NOT NULL,
    referred_by_id integer,
    referral_completed_at timestamp without time zone,
    phone_verification_otp_secret character varying(32),
    enrollment_sms_notifications boolean DEFAULT true NOT NULL,
    enrollment_web_push_notifications boolean DEFAULT true NOT NULL,
    CONSTRAINT notification_tokens_positive_count CHECK ((notification_token_count >= 0))
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: webpush_devices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.webpush_devices (
    id bigint NOT NULL,
    user_id bigint,
    nickname character varying,
    browser character varying NOT NULL,
    operating_system character varying NOT NULL,
    notification_endpoint character varying NOT NULL,
    auth_key character varying NOT NULL,
    p256dh_key character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: webpush_devices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.webpush_devices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: webpush_devices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.webpush_devices_id_seq OWNED BY public.webpush_devices.id;


--
-- Name: ahoy_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ahoy_events ALTER COLUMN id SET DEFAULT nextval('public.ahoy_events_id_seq'::regclass);


--
-- Name: ahoy_visits id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ahoy_visits ALTER COLUMN id SET DEFAULT nextval('public.ahoy_visits_id_seq'::regclass);


--
-- Name: blazer_audits id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_audits ALTER COLUMN id SET DEFAULT nextval('public.blazer_audits_id_seq'::regclass);


--
-- Name: blazer_checks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_checks ALTER COLUMN id SET DEFAULT nextval('public.blazer_checks_id_seq'::regclass);


--
-- Name: blazer_dashboard_queries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_dashboard_queries ALTER COLUMN id SET DEFAULT nextval('public.blazer_dashboard_queries_id_seq'::regclass);


--
-- Name: blazer_dashboards id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_dashboards ALTER COLUMN id SET DEFAULT nextval('public.blazer_dashboards_id_seq'::regclass);


--
-- Name: blazer_queries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_queries ALTER COLUMN id SET DEFAULT nextval('public.blazer_queries_id_seq'::regclass);


--
-- Name: course_section_indices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_section_indices ALTER COLUMN id SET DEFAULT nextval('public.course_section_indices_id_seq'::regclass);


--
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- Name: enrollment_appointments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollment_appointments ALTER COLUMN id SET DEFAULT nextval('public.enrollment_appointments_id_seq'::regclass);


--
-- Name: enrollment_data id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollment_data ALTER COLUMN id SET DEFAULT nextval('public.enrollment_data_id_seq'::regclass);


--
-- Name: grade_distributions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grade_distributions ALTER COLUMN id SET DEFAULT nextval('public.grade_distributions_id_seq'::regclass);


--
-- Name: instructors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instructors ALTER COLUMN id SET DEFAULT nextval('public.instructors_id_seq'::regclass);


--
-- Name: mailkick_subscriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mailkick_subscriptions ALTER COLUMN id SET DEFAULT nextval('public.mailkick_subscriptions_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: pay_charges id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_charges ALTER COLUMN id SET DEFAULT nextval('public.pay_charges_id_seq'::regclass);


--
-- Name: pay_customers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_customers ALTER COLUMN id SET DEFAULT nextval('public.pay_customers_id_seq'::regclass);


--
-- Name: pay_merchants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_merchants ALTER COLUMN id SET DEFAULT nextval('public.pay_merchants_id_seq'::regclass);


--
-- Name: pay_payment_methods id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_payment_methods ALTER COLUMN id SET DEFAULT nextval('public.pay_payment_methods_id_seq'::regclass);


--
-- Name: pay_subscriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_subscriptions ALTER COLUMN id SET DEFAULT nextval('public.pay_subscriptions_id_seq'::regclass);


--
-- Name: pay_webhooks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_webhooks ALTER COLUMN id SET DEFAULT nextval('public.pay_webhooks_id_seq'::regclass);


--
-- Name: relationships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relationships ALTER COLUMN id SET DEFAULT nextval('public.relationships_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: searchjoy_searches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.searchjoy_searches ALTER COLUMN id SET DEFAULT nextval('public.searchjoy_searches_id_seq'::regclass);


--
-- Name: sections id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sections ALTER COLUMN id SET DEFAULT nextval('public.sections_id_seq'::regclass);


--
-- Name: subject_areas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subject_areas ALTER COLUMN id SET DEFAULT nextval('public.subject_areas_id_seq'::regclass);


--
-- Name: terms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.terms ALTER COLUMN id SET DEFAULT nextval('public.terms_id_seq'::regclass);


--
-- Name: textbooks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.textbooks ALTER COLUMN id SET DEFAULT nextval('public.textbooks_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: webpush_devices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webpush_devices ALTER COLUMN id SET DEFAULT nextval('public.webpush_devices_id_seq'::regclass);


--
-- Name: ahoy_events ahoy_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ahoy_events
    ADD CONSTRAINT ahoy_events_pkey PRIMARY KEY (id);


--
-- Name: ahoy_visits ahoy_visits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ahoy_visits
    ADD CONSTRAINT ahoy_visits_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: blazer_audits blazer_audits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_audits
    ADD CONSTRAINT blazer_audits_pkey PRIMARY KEY (id);


--
-- Name: blazer_checks blazer_checks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_checks
    ADD CONSTRAINT blazer_checks_pkey PRIMARY KEY (id);


--
-- Name: blazer_dashboard_queries blazer_dashboard_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_dashboard_queries
    ADD CONSTRAINT blazer_dashboard_queries_pkey PRIMARY KEY (id);


--
-- Name: blazer_dashboards blazer_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_dashboards
    ADD CONSTRAINT blazer_dashboards_pkey PRIMARY KEY (id);


--
-- Name: blazer_queries blazer_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_queries
    ADD CONSTRAINT blazer_queries_pkey PRIMARY KEY (id);


--
-- Name: course_section_indices course_section_indices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_section_indices
    ADD CONSTRAINT course_section_indices_pkey PRIMARY KEY (id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: enrollment_appointments enrollment_appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollment_appointments
    ADD CONSTRAINT enrollment_appointments_pkey PRIMARY KEY (id);


--
-- Name: enrollment_data enrollment_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollment_data
    ADD CONSTRAINT enrollment_data_pkey PRIMARY KEY (id);


--
-- Name: grade_distributions grade_distributions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grade_distributions
    ADD CONSTRAINT grade_distributions_pkey PRIMARY KEY (id);


--
-- Name: instructors instructors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instructors
    ADD CONSTRAINT instructors_pkey PRIMARY KEY (id);


--
-- Name: mailkick_subscriptions mailkick_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mailkick_subscriptions
    ADD CONSTRAINT mailkick_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: pay_charges pay_charges_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_charges
    ADD CONSTRAINT pay_charges_pkey PRIMARY KEY (id);


--
-- Name: pay_customers pay_customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_customers
    ADD CONSTRAINT pay_customers_pkey PRIMARY KEY (id);


--
-- Name: pay_merchants pay_merchants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_merchants
    ADD CONSTRAINT pay_merchants_pkey PRIMARY KEY (id);


--
-- Name: pay_payment_methods pay_payment_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_payment_methods
    ADD CONSTRAINT pay_payment_methods_pkey PRIMARY KEY (id);


--
-- Name: pay_subscriptions pay_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_subscriptions
    ADD CONSTRAINT pay_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: pay_webhooks pay_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_webhooks
    ADD CONSTRAINT pay_webhooks_pkey PRIMARY KEY (id);


--
-- Name: relationships relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT relationships_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: searchjoy_searches searchjoy_searches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.searchjoy_searches
    ADD CONSTRAINT searchjoy_searches_pkey PRIMARY KEY (id);


--
-- Name: sections sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);


--
-- Name: subject_areas subject_areas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subject_areas
    ADD CONSTRAINT subject_areas_pkey PRIMARY KEY (id);


--
-- Name: terms terms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.terms
    ADD CONSTRAINT terms_pkey PRIMARY KEY (id);


--
-- Name: textbooks textbooks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.textbooks
    ADD CONSTRAINT textbooks_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webpush_devices webpush_devices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webpush_devices
    ADD CONSTRAINT webpush_devices_pkey PRIMARY KEY (id);


--
-- Name: index_ahoy_events_on_name_and_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ahoy_events_on_name_and_time ON public.ahoy_events USING btree (name, "time");


--
-- Name: index_ahoy_events_on_properties; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ahoy_events_on_properties ON public.ahoy_events USING gin (properties jsonb_path_ops);


--
-- Name: index_ahoy_events_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ahoy_events_on_user_id ON public.ahoy_events USING btree (user_id);


--
-- Name: index_ahoy_events_on_visit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ahoy_events_on_visit_id ON public.ahoy_events USING btree (visit_id);


--
-- Name: index_ahoy_visits_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ahoy_visits_on_user_id ON public.ahoy_visits USING btree (user_id);


--
-- Name: index_ahoy_visits_on_visit_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_ahoy_visits_on_visit_token ON public.ahoy_visits USING btree (visit_token);


--
-- Name: index_blazer_audits_on_query_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blazer_audits_on_query_id ON public.blazer_audits USING btree (query_id);


--
-- Name: index_blazer_audits_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blazer_audits_on_user_id ON public.blazer_audits USING btree (user_id);


--
-- Name: index_blazer_checks_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blazer_checks_on_creator_id ON public.blazer_checks USING btree (creator_id);


--
-- Name: index_blazer_checks_on_query_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blazer_checks_on_query_id ON public.blazer_checks USING btree (query_id);


--
-- Name: index_blazer_dashboard_queries_on_dashboard_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blazer_dashboard_queries_on_dashboard_id ON public.blazer_dashboard_queries USING btree (dashboard_id);


--
-- Name: index_blazer_dashboard_queries_on_query_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blazer_dashboard_queries_on_query_id ON public.blazer_dashboard_queries USING btree (query_id);


--
-- Name: index_blazer_dashboards_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blazer_dashboards_on_creator_id ON public.blazer_dashboards USING btree (creator_id);


--
-- Name: index_blazer_queries_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blazer_queries_on_creator_id ON public.blazer_queries USING btree (creator_id);


--
-- Name: index_course_section_indices_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_course_section_indices_on_course_id ON public.course_section_indices USING btree (course_id);


--
-- Name: index_course_section_indices_on_course_id_and_term_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_course_section_indices_on_course_id_and_term_id ON public.course_section_indices USING btree (course_id, term_id);


--
-- Name: index_course_section_indices_on_term_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_course_section_indices_on_term_id ON public.course_section_indices USING btree (term_id);


--
-- Name: index_courses_on_subject_area_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_courses_on_subject_area_id ON public.courses USING btree (subject_area_id);


--
-- Name: index_courses_on_superseding_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_courses_on_superseding_course_id ON public.courses USING btree (superseding_course_id);


--
-- Name: index_courses_on_title_and_number_and_subject_area_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_courses_on_title_and_number_and_subject_area_id ON public.courses USING btree (title, number, subject_area_id);


--
-- Name: index_courses_terms_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_courses_terms_on_course_id ON public.courses_terms USING btree (course_id);


--
-- Name: index_courses_terms_on_course_id_and_term_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_courses_terms_on_course_id_and_term_id ON public.courses_terms USING btree (course_id, term_id);


--
-- Name: index_courses_terms_on_term_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_courses_terms_on_term_id ON public.courses_terms USING btree (term_id);


--
-- Name: index_enrollment_appointments_on_term_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_enrollment_appointments_on_term_id ON public.enrollment_appointments USING btree (term_id);


--
-- Name: index_enrollment_appointments_on_term_id_and_pass; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_enrollment_appointments_on_term_id_and_pass ON public.enrollment_appointments USING btree (term_id, pass) WHERE (standing IS NULL);


--
-- Name: index_enrollment_appointments_on_term_id_and_pass_and_standing; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_enrollment_appointments_on_term_id_and_pass_and_standing ON public.enrollment_appointments USING btree (term_id, pass, standing);


--
-- Name: index_enrollment_data_on_section_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_enrollment_data_on_section_id ON public.enrollment_data USING btree (section_id);


--
-- Name: index_enrollment_data_on_section_id_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_enrollment_data_on_section_id_and_created_at ON public.enrollment_data USING btree (section_id, created_at);


--
-- Name: index_grade_distributions_on_section_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_grade_distributions_on_section_id ON public.grade_distributions USING btree (section_id);


--
-- Name: index_instructors_on_registrar_listing; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_instructors_on_registrar_listing ON public.instructors USING btree (registrar_listing);


--
-- Name: index_mailkick_subscriptions_on_subscriber_and_list; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_mailkick_subscriptions_on_subscriber_and_list ON public.mailkick_subscriptions USING btree (subscriber_type, subscriber_id, list);


--
-- Name: index_notifications_on_read_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_read_at ON public.notifications USING btree (read_at);


--
-- Name: index_notifications_on_recipient; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_recipient ON public.notifications USING btree (recipient_type, recipient_id);


--
-- Name: index_pay_charges_on_customer_id_and_processor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_pay_charges_on_customer_id_and_processor_id ON public.pay_charges USING btree (customer_id, processor_id);


--
-- Name: index_pay_charges_on_subscription_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pay_charges_on_subscription_id ON public.pay_charges USING btree (subscription_id);


--
-- Name: index_pay_customers_on_processor_and_processor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_pay_customers_on_processor_and_processor_id ON public.pay_customers USING btree (processor, processor_id);


--
-- Name: index_pay_merchants_on_owner_type_and_owner_id_and_processor; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pay_merchants_on_owner_type_and_owner_id_and_processor ON public.pay_merchants USING btree (owner_type, owner_id, processor);


--
-- Name: index_pay_payment_methods_on_customer_id_and_processor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_pay_payment_methods_on_customer_id_and_processor_id ON public.pay_payment_methods USING btree (customer_id, processor_id);


--
-- Name: index_pay_subscriptions_on_customer_id_and_processor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_pay_subscriptions_on_customer_id_and_processor_id ON public.pay_subscriptions USING btree (customer_id, processor_id);


--
-- Name: index_relationships_on_section_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_relationships_on_section_id ON public.relationships USING btree (section_id);


--
-- Name: index_relationships_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_relationships_on_user_id ON public.relationships USING btree (user_id);


--
-- Name: index_relationships_on_user_id_and_section_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_relationships_on_user_id_and_section_id ON public.relationships USING btree (user_id, section_id);


--
-- Name: index_reviews_on_relationship_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reviews_on_relationship_id ON public.reviews USING btree (relationship_id);


--
-- Name: index_reviews_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reviews_on_status ON public.reviews USING btree (status);


--
-- Name: index_searchjoy_searches_on_convertable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_searchjoy_searches_on_convertable ON public.searchjoy_searches USING btree (convertable_type, convertable_id);


--
-- Name: index_searchjoy_searches_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_searchjoy_searches_on_created_at ON public.searchjoy_searches USING btree (created_at);


--
-- Name: index_searchjoy_searches_on_search_type_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_searchjoy_searches_on_search_type_and_created_at ON public.searchjoy_searches USING btree (search_type, created_at);


--
-- Name: index_searchjoy_searches_on_search_type_query; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_searchjoy_searches_on_search_type_query ON public.searchjoy_searches USING btree (search_type, normalized_query, created_at);


--
-- Name: index_searchjoy_searches_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_searchjoy_searches_on_user_id ON public.searchjoy_searches USING btree (user_id);


--
-- Name: index_sections_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sections_on_course_id ON public.sections USING btree (course_id);


--
-- Name: index_sections_on_instructor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sections_on_instructor_id ON public.sections USING btree (instructor_id);


--
-- Name: index_sections_on_registrar_id_and_term_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_sections_on_registrar_id_and_term_id ON public.sections USING btree (registrar_id, term_id);


--
-- Name: index_sections_on_term_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sections_on_term_id ON public.sections USING btree (term_id);


--
-- Name: index_sections_textbooks_on_section_id_and_textbook_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_sections_textbooks_on_section_id_and_textbook_id ON public.sections_textbooks USING btree (section_id, textbook_id);


--
-- Name: index_subject_areas_on_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_subject_areas_on_code ON public.subject_areas USING btree (code);


--
-- Name: index_subject_areas_on_superseding_subject_area_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_subject_areas_on_superseding_subject_area_id ON public.subject_areas USING btree (superseding_subject_area_id);


--
-- Name: index_terms_on_start_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_terms_on_start_date ON public.terms USING btree (start_date);


--
-- Name: index_terms_on_term; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_terms_on_term ON public.terms USING btree (term);


--
-- Name: index_textbooks_on_isbn; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_textbooks_on_isbn ON public.textbooks USING btree (isbn);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_referral_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_referral_code ON public.users USING btree (referral_code);


--
-- Name: index_users_on_uid_and_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_uid_and_provider ON public.users USING btree (uid, provider);


--
-- Name: index_webpush_devices_on_notification_endpoint; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_webpush_devices_on_notification_endpoint ON public.webpush_devices USING btree (notification_endpoint);


--
-- Name: index_webpush_devices_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_webpush_devices_on_user_id ON public.webpush_devices USING btree (user_id);


--
-- Name: pay_customer_owner_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pay_customer_owner_index ON public.pay_customers USING btree (owner_type, owner_id, deleted_at, "default");


--
-- Name: sections fk_rails_099c045db9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT fk_rails_099c045db9 FOREIGN KEY (instructor_id) REFERENCES public.instructors(id);


--
-- Name: course_section_indices fk_rails_1a684a5166; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_section_indices
    ADD CONSTRAINT fk_rails_1a684a5166 FOREIGN KEY (term_id) REFERENCES public.terms(id);


--
-- Name: sections fk_rails_20b1e5de46; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT fk_rails_20b1e5de46 FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: subject_areas fk_rails_40209bccac; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subject_areas
    ADD CONSTRAINT fk_rails_40209bccac FOREIGN KEY (superseding_subject_area_id) REFERENCES public.subject_areas(id);


--
-- Name: enrollment_appointments fk_rails_42ba9761ba; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollment_appointments
    ADD CONSTRAINT fk_rails_42ba9761ba FOREIGN KEY (term_id) REFERENCES public.terms(id);


--
-- Name: pay_charges fk_rails_44a2c276fa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_charges
    ADD CONSTRAINT fk_rails_44a2c276fa FOREIGN KEY (subscription_id) REFERENCES public.pay_subscriptions(id);


--
-- Name: courses_terms fk_rails_46187b7551; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses_terms
    ADD CONSTRAINT fk_rails_46187b7551 FOREIGN KEY (term_id) REFERENCES public.terms(id);


--
-- Name: reviews fk_rails_583a5158f7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_rails_583a5158f7 FOREIGN KEY (relationship_id) REFERENCES public.relationships(id);


--
-- Name: courses fk_rails_6bf9814699; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT fk_rails_6bf9814699 FOREIGN KEY (superseding_course_id) REFERENCES public.courses(id);


--
-- Name: courses_terms fk_rails_7fcc9962e0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses_terms
    ADD CONSTRAINT fk_rails_7fcc9962e0 FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: sections_textbooks fk_rails_80ab4a23d4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sections_textbooks
    ADD CONSTRAINT fk_rails_80ab4a23d4 FOREIGN KEY (section_id) REFERENCES public.sections(id);


--
-- Name: webpush_devices fk_rails_848699f77d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webpush_devices
    ADD CONSTRAINT fk_rails_848699f77d FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: sections_textbooks fk_rails_9685d2088f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sections_textbooks
    ADD CONSTRAINT fk_rails_9685d2088f FOREIGN KEY (textbook_id) REFERENCES public.textbooks(id);


--
-- Name: enrollment_data fk_rails_9744b3d66e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollment_data
    ADD CONSTRAINT fk_rails_9744b3d66e FOREIGN KEY (section_id) REFERENCES public.sections(id);


--
-- Name: relationships fk_rails_a3d77c3b00; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT fk_rails_a3d77c3b00 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: sections fk_rails_ae061b0a82; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT fk_rails_ae061b0a82 FOREIGN KEY (term_id) REFERENCES public.terms(id);


--
-- Name: pay_charges fk_rails_b19d32f835; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_charges
    ADD CONSTRAINT fk_rails_b19d32f835 FOREIGN KEY (customer_id) REFERENCES public.pay_customers(id);


--
-- Name: pay_subscriptions fk_rails_b7cd64d378; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_subscriptions
    ADD CONSTRAINT fk_rails_b7cd64d378 FOREIGN KEY (customer_id) REFERENCES public.pay_customers(id);


--
-- Name: pay_payment_methods fk_rails_c78c6cb84d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_payment_methods
    ADD CONSTRAINT fk_rails_c78c6cb84d FOREIGN KEY (customer_id) REFERENCES public.pay_customers(id);


--
-- Name: courses fk_rails_e9bb54923c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT fk_rails_e9bb54923c FOREIGN KEY (subject_area_id) REFERENCES public.subject_areas(id);


--
-- Name: relationships fk_rails_f16b62718d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT fk_rails_f16b62718d FOREIGN KEY (section_id) REFERENCES public.sections(id);


--
-- Name: grade_distributions fk_rails_f42c9e743e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grade_distributions
    ADD CONSTRAINT fk_rails_f42c9e743e FOREIGN KEY (section_id) REFERENCES public.sections(id);


--
-- Name: course_section_indices fk_rails_f7828adea6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_section_indices
    ADD CONSTRAINT fk_rails_f7828adea6 FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20200915043740'),
('20200915050134'),
('20200919054932'),
('20200919055532'),
('20201029153604'),
('20201031051018'),
('20201031052239'),
('20201031053652'),
('20201031154205'),
('20201101173449'),
('20201110001628'),
('20201118022443'),
('20201121234408'),
('20201128193041'),
('20201201163053'),
('20201205002117'),
('20201207000548'),
('20201210162358'),
('20201210164646'),
('20201212224224'),
('20201212232816'),
('20201218014901'),
('20201223180710'),
('20201231005534'),
('20210102190233'),
('20210103195202'),
('20210108064701'),
('20210118034701'),
('20210210201840'),
('20210212203112'),
('20210326003758'),
('20210425033907'),
('20210428042142'),
('20210508161423'),
('20210510182758'),
('20210513011550'),
('20210516205451'),
('20210519060240'),
('20210525175152'),
('20210528213312'),
('20210602221458'),
('20210611182713'),
('20210616012237'),
('20210821170158'),
('20210911200124'),
('20211023173319'),
('20211209051103'),
('20211211060629'),
('20211211185640'),
('20211212182543'),
('20220116054039'),
('20220131054151'),
('20220227225317'),
('20220303051621'),
('20220817045634'),
('20221226072833'),
('20230204030922'),
('20230228014101'),
('20230421233948'),
('20230430161016'),
('20230511033013'),
('20230718192047'),
('20230820174337');


