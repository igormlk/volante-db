-- public.tenants definition

-- Drop table

-- DROP TABLE public.tenants;

CREATE TABLE public.tenants (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	"name" varchar(255) NOT NULL,
	"createdAt" timestamptz NOT NULL,
	"updatedAt" timestamptz NOT NULL,
	CONSTRAINT tenants_name_key UNIQUE (name),
	CONSTRAINT tenants_pkey PRIMARY KEY (id)
);


-- public.permissions definition

-- Drop table

-- DROP TABLE public.permissions;

CREATE TABLE public.permissions (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	"tenantId" uuid NOT NULL,
	"createdAt" timestamptz NOT NULL,
	"updatedAt" timestamptz NOT NULL,
	CONSTRAINT permissions_pkey PRIMARY KEY (id),
	CONSTRAINT "permissions_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id)
);


-- public.roles definition

-- Drop table

-- DROP TABLE public.roles;

CREATE TABLE public.roles (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	"roleName" varchar(255) NOT NULL,
	"tenantId" uuid NOT NULL,
	"createdAt" timestamptz NOT NULL,
	"updatedAt" timestamptz NOT NULL,
	CONSTRAINT roles_pkey PRIMARY KEY (id),
	CONSTRAINT "roles_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id)
);


-- public.users definition

-- Drop table

-- DROP TABLE public.users;

CREATE TABLE public.users (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	"firstName" varchar(255) NOT NULL,
	"lastName" varchar(255) NULL,
	username varchar(255) NOT NULL,
	"password" varchar(255) NOT NULL,
	"tenantId" uuid NOT NULL,
	"roleId" uuid NULL,
	"createdAt" timestamptz NOT NULL,
	"updatedAt" timestamptz NOT NULL,
	CONSTRAINT users_pkey PRIMARY KEY (id),
	CONSTRAINT "users_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public.roles(id),
	CONSTRAINT "users_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id)
);


-- public.vehicles definition

-- Drop table

-- DROP TABLE public.vehicles;

CREATE TABLE public.vehicles (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	plate varchar(7) NOT NULL,
	brand varchar(255) NOT NULL,
	model varchar(255) NOT NULL,
	"year" int4 NOT NULL,
	color varchar(255) NOT NULL,
	km varchar(255) NOT NULL,
	fuel varchar(255) NOT NULL,
	chassi varchar(255) NOT NULL,
	"tenantId" uuid NOT NULL,
	"createdBy" uuid NOT NULL,
	"updatedBy" uuid NULL,
	"createdAt" timestamptz NOT NULL,
	"updatedAt" timestamptz NOT NULL,
	CONSTRAINT vehicles_pkey PRIMARY KEY (id),
	CONSTRAINT "vehicles_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES public.users(id),
	CONSTRAINT "vehicles_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE,
	CONSTRAINT "vehicles_updatedBy_fkey" FOREIGN KEY ("updatedBy") REFERENCES public.users(id)
);


-- public."catalog" definition

-- Drop table

-- DROP TABLE public."catalog";

CREATE TABLE public."catalog" (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	description varchar(255) NOT NULL,
	sku varchar(25) NULL,
	value numeric(10, 2) NOT NULL,
	"type" varchar(255) NOT NULL,
	"hasConditionalPrice" bool DEFAULT false NOT NULL,
	"tenantId" uuid NOT NULL,
	"createdBy" uuid NOT NULL,
	"updatedBy" uuid NULL,
	"createdAt" timestamptz NOT NULL,
	"updatedAt" timestamptz NOT NULL,
	CONSTRAINT catalog_pkey PRIMARY KEY (id),
	CONSTRAINT catalog_sku_key UNIQUE (sku),
	CONSTRAINT "catalog_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES public.users(id),
	CONSTRAINT "catalog_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE,
	CONSTRAINT "catalog_updatedBy_fkey" FOREIGN KEY ("updatedBy") REFERENCES public.users(id)
);


-- public.customers definition

-- Drop table

-- DROP TABLE public.customers;

CREATE TABLE public.customers (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	"name" varchar(255) NOT NULL,
	cpf varchar(15) NULL,
	email varchar(255) NULL,
	phone varchar(15) NULL,
	address varchar(255) NULL,
	"tenantId" uuid NOT NULL,
	"createdBy" uuid NOT NULL,
	"updatedBy" uuid NULL,
	"createdAt" timestamptz NOT NULL,
	"updatedAt" timestamptz NOT NULL,
	CONSTRAINT customers_pkey PRIMARY KEY (id),
	CONSTRAINT "customers_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES public.users(id),
	CONSTRAINT "customers_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE,
	CONSTRAINT "customers_updatedBy_fkey" FOREIGN KEY ("updatedBy") REFERENCES public.users(id)
);


-- public.employees definition

-- Drop table

-- DROP TABLE public.employees;

CREATE TABLE public.employees (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	"name" varchar(255) NOT NULL,
	cpf varchar(15) NULL,
	phone varchar(15) NOT NULL,
	email varchar(255) NULL,
	"tenantId" uuid NOT NULL,
	"createdBy" uuid NOT NULL,
	"updatedBy" uuid NULL,
	"createdAt" timestamptz NOT NULL,
	"updatedAt" timestamptz NOT NULL,
	CONSTRAINT employees_cpf_key UNIQUE (cpf),
	CONSTRAINT employees_pkey PRIMARY KEY (id),
	CONSTRAINT "employees_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES public.users(id),
	CONSTRAINT "employees_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE,
	CONSTRAINT "employees_updatedBy_fkey" FOREIGN KEY ("updatedBy") REFERENCES public.users(id)
);


-- public.insurance_companies definition

-- Drop table

-- DROP TABLE public.insurance_companies;

CREATE TABLE public.insurance_companies (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	"name" varchar(255) NOT NULL,
	phone varchar(15) NOT NULL,
	email varchar(255) NULL,
	"tenantId" uuid NOT NULL,
	"createdBy" uuid NOT NULL,
	"updatedBy" uuid NULL,
	"createdAt" timestamptz NOT NULL,
	"updatedAt" timestamptz NOT NULL,
	CONSTRAINT insurance_companies_pkey PRIMARY KEY (id),
	CONSTRAINT "insurance_companies_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES public.users(id),
	CONSTRAINT "insurance_companies_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE,
	CONSTRAINT "insurance_companies_updatedBy_fkey" FOREIGN KEY ("updatedBy") REFERENCES public.users(id)
);


-- public.role_permissions definition

-- Drop table

-- DROP TABLE public.role_permissions;

CREATE TABLE public.role_permissions (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	"roleId" uuid NOT NULL,
	"permissionId" uuid NOT NULL,
	"tenantId" uuid NOT NULL,
	"createdAt" timestamptz NOT NULL,
	"updatedAt" timestamptz NOT NULL,
	CONSTRAINT role_permissions_pkey PRIMARY KEY (id),
	CONSTRAINT "role_permissions_roleId_permissionId_key" UNIQUE ("roleId", "permissionId"),
	CONSTRAINT "role_permissions_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES public.permissions(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT "role_permissions_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public.roles(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT "role_permissions_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id)
);


-- public.service_orders definition

-- Drop table

-- DROP TABLE public.service_orders;

CREATE TABLE public.service_orders (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	status varchar(255) NOT NULL,
	"customerId" uuid NOT NULL,
	"vehicleId" uuid NOT NULL,
	"insuranceCompanyId" uuid NULL,
	"startAt" timestamptz NULL,
	"endAt" timestamptz NULL,
	note varchar(255) NULL,
	"tenantId" uuid NOT NULL,
	"createdBy" uuid NOT NULL,
	"updatedBy" uuid NULL,
	"createdAt" timestamptz NOT NULL,
	"updatedAt" timestamptz NOT NULL,
	CONSTRAINT service_orders_pkey PRIMARY KEY (id),
	CONSTRAINT "service_orders_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES public.users(id),
	CONSTRAINT "service_orders_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public.customers(id) ON UPDATE CASCADE,
	CONSTRAINT "service_orders_insuranceCompanyId_fkey" FOREIGN KEY ("insuranceCompanyId") REFERENCES public.insurance_companies(id),
	CONSTRAINT "service_orders_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id),
	CONSTRAINT "service_orders_updatedBy_fkey" FOREIGN KEY ("updatedBy") REFERENCES public.users(id),
	CONSTRAINT "service_orders_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES public.vehicles(id) ON UPDATE CASCADE
);


-- public.suppliers definition

-- Drop table

-- DROP TABLE public.suppliers;

CREATE TABLE public.suppliers (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	"name" varchar(255) NOT NULL,
	cnpj varchar(18) NULL,
	phone varchar(15) NOT NULL,
	email varchar(255) NULL,
	address varchar(255) NULL,
	contact_person varchar(255) NULL,
	"tenantId" uuid NOT NULL,
	"createdBy" uuid NOT NULL,
	"updatedBy" uuid NULL,
	"createdAt" timestamptz NOT NULL,
	"updatedAt" timestamptz NOT NULL,
	CONSTRAINT suppliers_cnpj_key UNIQUE (cnpj),
	CONSTRAINT suppliers_pkey PRIMARY KEY (id),
	CONSTRAINT "suppliers_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES public.users(id),
	CONSTRAINT "suppliers_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE,
	CONSTRAINT "suppliers_updatedBy_fkey" FOREIGN KEY ("updatedBy") REFERENCES public.users(id)
);


-- public.service_order_items definition

-- Drop table

-- DROP TABLE public.service_order_items;

CREATE TABLE public.service_order_items (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	description varchar(255) NOT NULL,
	value numeric(10, 2) NOT NULL,
	quantity int4 DEFAULT 1 NOT NULL,
	discount numeric(10, 2) NULL,
	total numeric(10, 2) NOT NULL,
	"type" varchar(255) DEFAULT 'parts'::character varying NULL,
	"tenantId" uuid NOT NULL,
	"createdBy" uuid NOT NULL,
	"updatedBy" uuid NULL,
	"createdAt" timestamptz NOT NULL,
	"updatedAt" timestamptz NOT NULL,
	"serviceOrderId" uuid NULL,
	"catalogItemId" uuid NULL,
	CONSTRAINT service_order_items_pkey PRIMARY KEY (id),
	CONSTRAINT "service_order_items_catalogItemId_fkey" FOREIGN KEY ("catalogItemId") REFERENCES public."catalog"(id) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT "service_order_items_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES public.users(id),
	CONSTRAINT "service_order_items_serviceOrderId_fkey" FOREIGN KEY ("serviceOrderId") REFERENCES public.service_orders(id) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT "service_order_items_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE,
	CONSTRAINT "service_order_items_updatedBy_fkey" FOREIGN KEY ("updatedBy") REFERENCES public.users(id)
);


INSERT INTO public.tenants
(id, "name", "createdAt", "updatedAt")
VALUES('98b73864-4727-433a-b3e5-73f7a689f2f4'::uuid, 'GERACAO 2000', '1969-12-31 19:00:00.000', '1969-12-31 19:00:00.000');


INSERT INTO public.users
(id, "firstName", "lastName", username, "password", "tenantId", "roleId", "createdAt", "updatedAt")
VALUES('d84c08a5-4b9c-4538-8eb1-ba3f0c7f766b'::uuid, 'Igor', 'Campos', 'igor', '$2a$12$ERczgPVAqHrAHGPhEjcozO/1qytxQUL3tZFajk.B6rWB1Gb13vtli', '98b73864-4727-433a-b3e5-73f7a689f2f4'::uuid, NULL, '2024-11-06 23:04:13.957', '2024-11-06 23:04:13.957');
