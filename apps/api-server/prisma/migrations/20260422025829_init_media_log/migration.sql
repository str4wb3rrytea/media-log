-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('ACTIVE', 'INACTIVE');

-- CreateEnum
CREATE TYPE "ConsumptionStatus" AS ENUM ('DNF', 'CONSUMING', 'FINISHED', 'RECONSUMING', 'RECONSUMED', 'RECONSUMPTION_DNF');

-- CreateTable
CREATE TABLE "users" (
    "user_id" TEXT NOT NULL,
    "user_status" "UserStatus" NOT NULL DEFAULT 'ACTIVE',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "users_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "branches" (
    "branch_id" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "name" TEXT,
    "user" TEXT NOT NULL,
    "parent_branch" TEXT,

    CONSTRAINT "branches_pkey" PRIMARY KEY ("branch_id")
);

-- CreateTable
CREATE TABLE "display_legends" (
    "display_legend_id" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "theme" TEXT NOT NULL,
    "icon" TEXT NOT NULL,
    "user" TEXT NOT NULL,

    CONSTRAINT "display_legends_pkey" PRIMARY KEY ("display_legend_id")
);

-- CreateTable
CREATE TABLE "templates" (
    "template_id" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "template_name" TEXT NOT NULL,
    "template_body" TEXT NOT NULL,
    "user" TEXT NOT NULL,

    CONSTRAINT "templates_pkey" PRIMARY KEY ("template_id")
);

-- CreateTable
CREATE TABLE "reflection_displays" (
    "reflection_display_id" TEXT NOT NULL,
    "user" TEXT NOT NULL,
    "display_legend" TEXT NOT NULL,
    "parent_branch" TEXT NOT NULL,

    CONSTRAINT "reflection_displays_pkey" PRIMARY KEY ("reflection_display_id")
);

-- CreateTable
CREATE TABLE "reflections" (
    "reflection_id" TEXT NOT NULL,
    "consumption_status" "ConsumptionStatus" NOT NULL DEFAULT 'CONSUMING',
    "started_consuming" TIMESTAMP(3),
    "finished_consuming" TIMESTAMP(3),
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "content" TEXT,
    "metadata" JSONB,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "user" TEXT NOT NULL,
    "reflection_display" TEXT NOT NULL,

    CONSTRAINT "reflections_pkey" PRIMARY KEY ("reflection_id")
);

-- AddForeignKey
ALTER TABLE "branches" ADD CONSTRAINT "branches_user_fkey" FOREIGN KEY ("user") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "branches" ADD CONSTRAINT "branches_parent_branch_fkey" FOREIGN KEY ("parent_branch") REFERENCES "branches"("branch_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "display_legends" ADD CONSTRAINT "display_legends_user_fkey" FOREIGN KEY ("user") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "templates" ADD CONSTRAINT "templates_user_fkey" FOREIGN KEY ("user") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reflection_displays" ADD CONSTRAINT "reflection_displays_user_fkey" FOREIGN KEY ("user") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reflection_displays" ADD CONSTRAINT "reflection_displays_display_legend_fkey" FOREIGN KEY ("display_legend") REFERENCES "display_legends"("display_legend_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reflection_displays" ADD CONSTRAINT "reflection_displays_parent_branch_fkey" FOREIGN KEY ("parent_branch") REFERENCES "branches"("branch_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reflections" ADD CONSTRAINT "reflections_user_fkey" FOREIGN KEY ("user") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reflections" ADD CONSTRAINT "reflections_reflection_display_fkey" FOREIGN KEY ("reflection_display") REFERENCES "reflection_displays"("reflection_display_id") ON DELETE RESTRICT ON UPDATE CASCADE;
