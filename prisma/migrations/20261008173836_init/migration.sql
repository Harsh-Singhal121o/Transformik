-- CreateTable
CREATE TABLE "tools_summary" (
    "id" UUID NOT NULL,
    "tool_name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "url" TEXT,
    "logo" TEXT,
    "one_line_description" TEXT,
    "pricing_model" TEXT,
    "category" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tools_summary_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tools_details" (
    "id" UUID NOT NULL,
    "description" TEXT,
    "how_to_use" TEXT,
    "use_cases" TEXT,
    "pros" TEXT,
    "cons" TEXT,
    "pricing" TEXT,
    "faqs" JSONB,
    "screenshots" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tools_details_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "blogs_summary" (
    "id" UUID NOT NULL,
    "title" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "excerpt" TEXT,
    "featured_image" TEXT,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "blogs_summary_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "blogs_details" (
    "id" UUID NOT NULL,
    "content" TEXT,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "blogs_details_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categories_details" (
    "id" SERIAL NOT NULL,
    "slug" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "meta_title" TEXT,
    "meta_description" TEXT,
    "faqs" JSONB,
    "description" TEXT,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "categories_details_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "tools_summary_slug_key" ON "tools_summary"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "blogs_summary_slug_key" ON "blogs_summary"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "categories_details_slug_key" ON "categories_details"("slug");

-- AddForeignKey
ALTER TABLE "tools_details" ADD CONSTRAINT "tools_details_id_fkey" FOREIGN KEY ("id") REFERENCES "tools_summary"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "blogs_details" ADD CONSTRAINT "blogs_details_id_fkey" FOREIGN KEY ("id") REFERENCES "blogs_summary"("id") ON DELETE CASCADE ON UPDATE CASCADE;
