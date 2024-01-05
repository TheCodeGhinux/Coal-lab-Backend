-- CreateEnum
CREATE TYPE "Roles" AS ENUM ('Admin', 'User', 'Creator');

-- CreateEnum
CREATE TYPE "Compactibility" AS ENUM ('Figma', 'Framer', 'WordPress');

-- CreateEnum
CREATE TYPE "NotificationType" AS ENUM ('TEMPLATE_UPDATE', 'TEMPLATE_DOWNLOADED', 'TEMPLATE_REMOVED', 'TEMPLATE_INTERACTION');

-- CreateTable
CREATE TABLE "User" (
    "userID" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "bio" TEXT,
    "profileImage" TEXT,
    "coverImage" TEXT,
    "googleAccountID" TEXT,
    "displayName" TEXT,
    "firstName" TEXT,
    "lastName" TEXT,
    "Role" "Roles" NOT NULL DEFAULT 'User',
    "slug" TEXT NOT NULL,
    "otp_enabled" BOOLEAN NOT NULL DEFAULT false,
    "otp_verified" BOOLEAN NOT NULL DEFAULT false,
    "isVerified" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "User_pkey" PRIMARY KEY ("userID")
);

-- CreateTable
CREATE TABLE "Template" (
    "templateID" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "fileSize" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUpdate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "compactibility" "Compactibility" NOT NULL,
    "isPublic" BOOLEAN NOT NULL DEFAULT false,
    "slug" TEXT NOT NULL,
    "userUserID" TEXT NOT NULL,

    CONSTRAINT "Template_pkey" PRIMARY KEY ("templateID")
);

-- CreateTable
CREATE TABLE "Page" (
    "pageID" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "image" TEXT[],
    "templateTemplateID" TEXT NOT NULL,

    CONSTRAINT "Page_pkey" PRIMARY KEY ("pageID")
);

-- CreateTable
CREATE TABLE "TemplateAnalytics" (
    "id" TEXT NOT NULL,
    "templateID" TEXT NOT NULL,
    "downloads" INTEGER NOT NULL,
    "viewCount" INTEGER NOT NULL,
    "revenue" INTEGER NOT NULL,
    "templateTemplateID" TEXT NOT NULL,

    CONSTRAINT "TemplateAnalytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Color" (
    "colorID" TEXT NOT NULL,
    "hexCode" TEXT NOT NULL,
    "templateTemplateID" TEXT NOT NULL,

    CONSTRAINT "Color_pkey" PRIMARY KEY ("colorID")
);

-- CreateTable
CREATE TABLE "Comment" (
    "commentID" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "templateTemplateID" TEXT NOT NULL,

    CONSTRAINT "Comment_pkey" PRIMARY KEY ("commentID")
);

-- CreateTable
CREATE TABLE "Rating" (
    "ratingID" TEXT NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "templateTemplateID" TEXT NOT NULL,

    CONSTRAINT "Rating_pkey" PRIMARY KEY ("ratingID")
);

-- CreateTable
CREATE TABLE "Payment" (
    "paymentID" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "transactionDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userUserID" TEXT NOT NULL,
    "templateTemplateID" TEXT NOT NULL,

    CONSTRAINT "Payment_pkey" PRIMARY KEY ("paymentID")
);

-- CreateTable
CREATE TABLE "SocialLink" (
    "LinkID" TEXT NOT NULL,
    "websiteURL" TEXT NOT NULL,
    "twitterURL" TEXT NOT NULL,
    "githubURL" TEXT NOT NULL,
    "instagramURL" TEXT NOT NULL,
    "userUserID" TEXT NOT NULL,

    CONSTRAINT "SocialLink_pkey" PRIMARY KEY ("LinkID")
);

-- CreateTable
CREATE TABLE "OTP" (
    "otpID" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userUserID" TEXT NOT NULL,

    CONSTRAINT "OTP_pkey" PRIMARY KEY ("otpID")
);

-- CreateTable
CREATE TABLE "PasswordReset" (
    "id" TEXT NOT NULL,
    "resetCode" TEXT NOT NULL,
    "expiryTimeStamp" TIMESTAMP(3) NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "userUserID" TEXT NOT NULL,

    CONSTRAINT "PasswordReset_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PrivacySetting" (
    "id" TEXT NOT NULL,
    "isPublic" BOOLEAN NOT NULL DEFAULT true,
    "userUserID" TEXT NOT NULL,

    CONSTRAINT "PrivacySetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Security" (
    "securityID" TEXT NOT NULL,

    CONSTRAINT "Security_pkey" PRIMARY KEY ("securityID")
);

-- CreateTable
CREATE TABLE "UserSupportTicket" (
    "ticketID" TEXT NOT NULL,
    "issueDescription" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "userUserID" TEXT NOT NULL,

    CONSTRAINT "UserSupportTicket_pkey" PRIMARY KEY ("ticketID")
);

-- CreateTable
CREATE TABLE "CreatorVerification" (
    "verificationID" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "userUserID" TEXT NOT NULL,

    CONSTRAINT "CreatorVerification_pkey" PRIMARY KEY ("verificationID")
);

-- CreateTable
CREATE TABLE "Notification" (
    "id" TEXT NOT NULL,
    "type" "NotificationType" NOT NULL,
    "message" TEXT NOT NULL,
    "read" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "users" TEXT[],
    "userUserID" TEXT NOT NULL,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NotificationPreferences" (
    "ID" TEXT NOT NULL,
    "type" "NotificationType" NOT NULL,
    "push" BOOLEAN NOT NULL DEFAULT true,
    "email" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userUserID" TEXT NOT NULL,

    CONSTRAINT "NotificationPreferences_pkey" PRIMARY KEY ("ID")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_userID_key" ON "User"("userID");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_slug_key" ON "User"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Template_templateID_key" ON "Template"("templateID");

-- CreateIndex
CREATE UNIQUE INDEX "Template_slug_key" ON "Template"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Page_pageID_key" ON "Page"("pageID");

-- CreateIndex
CREATE UNIQUE INDEX "TemplateAnalytics_id_key" ON "TemplateAnalytics"("id");

-- CreateIndex
CREATE UNIQUE INDEX "TemplateAnalytics_templateID_key" ON "TemplateAnalytics"("templateID");

-- CreateIndex
CREATE UNIQUE INDEX "Color_colorID_key" ON "Color"("colorID");

-- CreateIndex
CREATE UNIQUE INDEX "Comment_commentID_key" ON "Comment"("commentID");

-- CreateIndex
CREATE UNIQUE INDEX "Rating_ratingID_key" ON "Rating"("ratingID");

-- CreateIndex
CREATE UNIQUE INDEX "Payment_paymentID_key" ON "Payment"("paymentID");

-- CreateIndex
CREATE UNIQUE INDEX "SocialLink_LinkID_key" ON "SocialLink"("LinkID");

-- CreateIndex
CREATE UNIQUE INDEX "OTP_otpID_key" ON "OTP"("otpID");

-- CreateIndex
CREATE UNIQUE INDEX "PasswordReset_id_key" ON "PasswordReset"("id");

-- CreateIndex
CREATE UNIQUE INDEX "PrivacySetting_id_key" ON "PrivacySetting"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Security_securityID_key" ON "Security"("securityID");

-- CreateIndex
CREATE UNIQUE INDEX "UserSupportTicket_ticketID_key" ON "UserSupportTicket"("ticketID");

-- CreateIndex
CREATE UNIQUE INDEX "CreatorVerification_verificationID_key" ON "CreatorVerification"("verificationID");

-- CreateIndex
CREATE UNIQUE INDEX "Notification_id_key" ON "Notification"("id");

-- CreateIndex
CREATE UNIQUE INDEX "NotificationPreferences_ID_key" ON "NotificationPreferences"("ID");

-- AddForeignKey
ALTER TABLE "Template" ADD CONSTRAINT "Template_userUserID_fkey" FOREIGN KEY ("userUserID") REFERENCES "User"("userID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Page" ADD CONSTRAINT "Page_templateTemplateID_fkey" FOREIGN KEY ("templateTemplateID") REFERENCES "Template"("templateID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TemplateAnalytics" ADD CONSTRAINT "TemplateAnalytics_templateTemplateID_fkey" FOREIGN KEY ("templateTemplateID") REFERENCES "Template"("templateID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Color" ADD CONSTRAINT "Color_templateTemplateID_fkey" FOREIGN KEY ("templateTemplateID") REFERENCES "Template"("templateID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_templateTemplateID_fkey" FOREIGN KEY ("templateTemplateID") REFERENCES "Template"("templateID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rating" ADD CONSTRAINT "Rating_templateTemplateID_fkey" FOREIGN KEY ("templateTemplateID") REFERENCES "Template"("templateID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_userUserID_fkey" FOREIGN KEY ("userUserID") REFERENCES "User"("userID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_templateTemplateID_fkey" FOREIGN KEY ("templateTemplateID") REFERENCES "Template"("templateID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SocialLink" ADD CONSTRAINT "SocialLink_userUserID_fkey" FOREIGN KEY ("userUserID") REFERENCES "User"("userID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OTP" ADD CONSTRAINT "OTP_userUserID_fkey" FOREIGN KEY ("userUserID") REFERENCES "User"("userID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PasswordReset" ADD CONSTRAINT "PasswordReset_userUserID_fkey" FOREIGN KEY ("userUserID") REFERENCES "User"("userID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PrivacySetting" ADD CONSTRAINT "PrivacySetting_userUserID_fkey" FOREIGN KEY ("userUserID") REFERENCES "User"("userID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSupportTicket" ADD CONSTRAINT "UserSupportTicket_userUserID_fkey" FOREIGN KEY ("userUserID") REFERENCES "User"("userID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CreatorVerification" ADD CONSTRAINT "CreatorVerification_userUserID_fkey" FOREIGN KEY ("userUserID") REFERENCES "User"("userID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_userUserID_fkey" FOREIGN KEY ("userUserID") REFERENCES "User"("userID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NotificationPreferences" ADD CONSTRAINT "NotificationPreferences_userUserID_fkey" FOREIGN KEY ("userUserID") REFERENCES "User"("userID") ON DELETE CASCADE ON UPDATE CASCADE;
