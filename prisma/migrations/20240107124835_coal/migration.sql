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
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
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
    "isPublic" BOOLEAN NOT NULL DEFAULT false,
    "slug" TEXT NOT NULL,
    "creatorID" TEXT NOT NULL,

    CONSTRAINT "Template_pkey" PRIMARY KEY ("templateID")
);

-- CreateTable
CREATE TABLE "Page" (
    "pageID" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "image" TEXT[],
    "templateID" TEXT NOT NULL,

    CONSTRAINT "Page_pkey" PRIMARY KEY ("pageID")
);

-- CreateTable
CREATE TABLE "TemplateAnalytics" (
    "analyticsID" TEXT NOT NULL,
    "templateID" TEXT NOT NULL,
    "downloads" INTEGER NOT NULL,
    "viewCount" INTEGER NOT NULL,
    "revenue" INTEGER NOT NULL,

    CONSTRAINT "TemplateAnalytics_pkey" PRIMARY KEY ("analyticsID")
);

-- CreateTable
CREATE TABLE "Color" (
    "colorID" TEXT NOT NULL,
    "hexCode" TEXT NOT NULL,
    "templateID" TEXT NOT NULL,

    CONSTRAINT "Color_pkey" PRIMARY KEY ("colorID")
);

-- CreateTable
CREATE TABLE "Comment" (
    "commentID" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "templateID" TEXT NOT NULL,

    CONSTRAINT "Comment_pkey" PRIMARY KEY ("commentID")
);

-- CreateTable
CREATE TABLE "Rating" (
    "ratingID" TEXT NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "templateTemplateID" TEXT,

    CONSTRAINT "Rating_pkey" PRIMARY KEY ("ratingID")
);

-- CreateTable
CREATE TABLE "OTP" (
    "otpID" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userID" TEXT NOT NULL,

    CONSTRAINT "OTP_pkey" PRIMARY KEY ("otpID")
);

-- CreateTable
CREATE TABLE "PasswordReset" (
    "userID" TEXT NOT NULL,
    "resetCode" TEXT NOT NULL,
    "expiryTimeStamp" TIMESTAMP(3) NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "PasswordReset_pkey" PRIMARY KEY ("userID")
);

-- CreateTable
CREATE TABLE "Payment" (
    "paymentID" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "userID" TEXT NOT NULL,
    "templateID" TEXT NOT NULL,
    "transactionDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Payment_pkey" PRIMARY KEY ("paymentID")
);

-- CreateTable
CREATE TABLE "PrivacySetting" (
    "privacySettingID" TEXT NOT NULL,
    "userID" TEXT NOT NULL,
    "isPublic" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "PrivacySetting_pkey" PRIMARY KEY ("privacySettingID")
);

-- CreateTable
CREATE TABLE "SocialLink" (
    "linkID" TEXT NOT NULL,
    "websiteURL" TEXT NOT NULL,
    "twitterURL" TEXT NOT NULL,
    "githubURL" TEXT NOT NULL,
    "instagramURL" TEXT NOT NULL,
    "userID" TEXT NOT NULL,

    CONSTRAINT "SocialLink_pkey" PRIMARY KEY ("linkID")
);

-- CreateTable
CREATE TABLE "UserSupportTicket" (
    "ticketID" TEXT NOT NULL,
    "userID" TEXT NOT NULL,
    "issueDescription" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "UserSupportTicket_pkey" PRIMARY KEY ("ticketID")
);

-- CreateTable
CREATE TABLE "CreatorVerification" (
    "verificationID" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "creatorID" TEXT NOT NULL,

    CONSTRAINT "CreatorVerification_pkey" PRIMARY KEY ("verificationID")
);

-- CreateTable
CREATE TABLE "NotificationPreferences" (
    "notificationPreferencesID" TEXT NOT NULL,
    "userID" TEXT NOT NULL,
    "type" "NotificationType" NOT NULL,
    "push" BOOLEAN NOT NULL DEFAULT true,
    "email" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "NotificationPreferences_pkey" PRIMARY KEY ("notificationPreferencesID")
);

-- CreateTable
CREATE TABLE "Notification" (
    "notificationID" TEXT NOT NULL,
    "userID" TEXT NOT NULL,
    "type" "NotificationType" NOT NULL,
    "message" TEXT NOT NULL,
    "read" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("notificationID")
);

-- CreateTable
CREATE TABLE "_analytics" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
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
CREATE UNIQUE INDEX "TemplateAnalytics_analyticsID_key" ON "TemplateAnalytics"("analyticsID");

-- CreateIndex
CREATE UNIQUE INDEX "Color_colorID_key" ON "Color"("colorID");

-- CreateIndex
CREATE UNIQUE INDEX "Comment_commentID_key" ON "Comment"("commentID");

-- CreateIndex
CREATE UNIQUE INDEX "Rating_ratingID_key" ON "Rating"("ratingID");

-- CreateIndex
CREATE UNIQUE INDEX "OTP_otpID_key" ON "OTP"("otpID");

-- CreateIndex
CREATE UNIQUE INDEX "OTP_userID_key" ON "OTP"("userID");

-- CreateIndex
CREATE UNIQUE INDEX "Payment_paymentID_key" ON "Payment"("paymentID");

-- CreateIndex
CREATE UNIQUE INDEX "PrivacySetting_privacySettingID_key" ON "PrivacySetting"("privacySettingID");

-- CreateIndex
CREATE UNIQUE INDEX "SocialLink_linkID_key" ON "SocialLink"("linkID");

-- CreateIndex
CREATE UNIQUE INDEX "UserSupportTicket_ticketID_key" ON "UserSupportTicket"("ticketID");

-- CreateIndex
CREATE UNIQUE INDEX "CreatorVerification_verificationID_key" ON "CreatorVerification"("verificationID");

-- CreateIndex
CREATE UNIQUE INDEX "CreatorVerification_creatorID_key" ON "CreatorVerification"("creatorID");

-- CreateIndex
CREATE UNIQUE INDEX "NotificationPreferences_notificationPreferencesID_key" ON "NotificationPreferences"("notificationPreferencesID");

-- CreateIndex
CREATE UNIQUE INDEX "Notification_notificationID_key" ON "Notification"("notificationID");

-- CreateIndex
CREATE UNIQUE INDEX "_analytics_AB_unique" ON "_analytics"("A", "B");

-- CreateIndex
CREATE INDEX "_analytics_B_index" ON "_analytics"("B");

-- AddForeignKey
ALTER TABLE "Template" ADD CONSTRAINT "Template_creatorID_fkey" FOREIGN KEY ("creatorID") REFERENCES "User"("userID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Page" ADD CONSTRAINT "Page_templateID_fkey" FOREIGN KEY ("templateID") REFERENCES "Template"("templateID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Color" ADD CONSTRAINT "Color_templateID_fkey" FOREIGN KEY ("templateID") REFERENCES "Template"("templateID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_templateID_fkey" FOREIGN KEY ("templateID") REFERENCES "Template"("templateID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rating" ADD CONSTRAINT "Rating_templateTemplateID_fkey" FOREIGN KEY ("templateTemplateID") REFERENCES "Template"("templateID") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OTP" ADD CONSTRAINT "OTP_userID_fkey" FOREIGN KEY ("userID") REFERENCES "User"("userID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PasswordReset" ADD CONSTRAINT "PasswordReset_userID_fkey" FOREIGN KEY ("userID") REFERENCES "User"("userID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_userID_fkey" FOREIGN KEY ("userID") REFERENCES "User"("userID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_templateID_fkey" FOREIGN KEY ("templateID") REFERENCES "Template"("templateID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PrivacySetting" ADD CONSTRAINT "PrivacySetting_userID_fkey" FOREIGN KEY ("userID") REFERENCES "User"("userID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SocialLink" ADD CONSTRAINT "SocialLink_userID_fkey" FOREIGN KEY ("userID") REFERENCES "User"("userID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSupportTicket" ADD CONSTRAINT "UserSupportTicket_userID_fkey" FOREIGN KEY ("userID") REFERENCES "User"("userID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CreatorVerification" ADD CONSTRAINT "CreatorVerification_creatorID_fkey" FOREIGN KEY ("creatorID") REFERENCES "User"("userID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NotificationPreferences" ADD CONSTRAINT "NotificationPreferences_userID_fkey" FOREIGN KEY ("userID") REFERENCES "User"("userID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_userID_fkey" FOREIGN KEY ("userID") REFERENCES "User"("userID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_analytics" ADD CONSTRAINT "_analytics_A_fkey" FOREIGN KEY ("A") REFERENCES "Template"("templateID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_analytics" ADD CONSTRAINT "_analytics_B_fkey" FOREIGN KEY ("B") REFERENCES "TemplateAnalytics"("analyticsID") ON DELETE CASCADE ON UPDATE CASCADE;
