#!/usr/bin/env bash

set -Eeuo pipefail

BUILD_DIR=nodejs
DIST_DIR=dist

source ../libBuild.sh

NJS16X_DIST_ARM64=$DIST_DIR/nodejs16x.arm64.zip
NJS18X_DIST_ARM64=$DIST_DIR/nodejs18x.arm64.zip
NJS20X_DIST_ARM64=$DIST_DIR/nodejs20x.arm64.zip

NJS16X_DIST_X86_64=$DIST_DIR/nodejs16x.x86_64.zip
NJS18X_DIST_X86_64=$DIST_DIR/nodejs18x.x86_64.zip
NJS20X_DIST_X86_64=$DIST_DIR/nodejs20x.x86_64.zip

function usage {
  	echo "./nodejs/publish-ecr-images.sh [nodejs16x|nodejs18x|nodejs20x]"
}

function build-nodejs16x-arm64 {
	echo "Building new relic layer for nodejs16.x (arm64)"
	rm -rf $BUILD_DIR $NJS16X_DIST_ARM64
	mkdir -p $DIST_DIR
	npm install --prefix $BUILD_DIR newrelic@latest
	mkdir -p $BUILD_DIR/node_modules/newrelic-lambda-wrapper
	cp index.js $BUILD_DIR/node_modules/newrelic-lambda-wrapper
	download_extension arm64
	zip -rq $NJS16X_DIST_ARM64 $BUILD_DIR $EXTENSION_DIST_DIR $EXTENSION_DIST_PREVIEW_FILE
	rm -rf $BUILD_DIR $EXTENSION_DIST_DIR $EXTENSION_DIST_PREVIEW_FILE
	echo "Build complete: ${NJS16X_DIST_ARM64}"
}


function build-nodejs16x-x86 {
	echo "Building new relic layer for nodejs16.x (x86_64)"
	rm -rf $BUILD_DIR $NJS16X_DIST_X86_64
	mkdir -p $DIST_DIR
	npm install --prefix $BUILD_DIR newrelic@latest
	mkdir -p $BUILD_DIR/node_modules/newrelic-lambda-wrapper
	cp index.js $BUILD_DIR/node_modules/newrelic-lambda-wrapper
	download_extension x86_64
	zip -rq $NJS16X_DIST_X86_64 $BUILD_DIR $EXTENSION_DIST_DIR $EXTENSION_DIST_PREVIEW_FILE
	rm -rf $BUILD_DIR $EXTENSION_DIST_DIR $EXTENSION_DIST_PREVIEW_FILE
	echo "Build complete: ${NJS16X_DIST_X86_64}"
}


function build-nodejs18x-arm64 {
	echo "Building new relic layer for nodejs18.x (arm64)"
	rm -rf $BUILD_DIR $NJS18X_DIST_ARM64
	mkdir -p $DIST_DIR
	npm install --prefix $BUILD_DIR newrelic@latest
	mkdir -p $BUILD_DIR/node_modules/newrelic-lambda-wrapper
	cp index.js $BUILD_DIR/node_modules/newrelic-lambda-wrapper
	download_extension arm64
	zip -rq $NJS18X_DIST_ARM64 $BUILD_DIR $EXTENSION_DIST_DIR $EXTENSION_DIST_PREVIEW_FILE
	rm -rf $BUILD_DIR $EXTENSION_DIST_DIR $EXTENSION_DIST_PREVIEW_FILE
	echo "Build complete: ${NJS18X_DIST_ARM64}"
}

function build-nodejs18x-x86 {
	echo "Building new relic layer for nodejs18.x (x86_64)"
	rm -rf $BUILD_DIR $NJS18X_DIST_X86_64
	mkdir -p $DIST_DIR
	npm install --prefix $BUILD_DIR newrelic@latest
	mkdir -p $BUILD_DIR/node_modules/newrelic-lambda-wrapper
	cp index.js $BUILD_DIR/node_modules/newrelic-lambda-wrapper
	download_extension x86_64
	zip -rq $NJS18X_DIST_X86_64 $BUILD_DIR $EXTENSION_DIST_DIR $EXTENSION_DIST_PREVIEW_FILE
	rm -rf $BUILD_DIR $EXTENSION_DIST_DIR $EXTENSION_DIST_PREVIEW_FILE
	echo "Build complete: ${NJS18X_DIST_X86_64}"
}


function build-nodejs20x-arm64 {
	echo "Building new relic layer for nodejs20.x (arm64)"
	rm -rf $BUILD_DIR $NJS20X_DIST_ARM64
	mkdir -p $DIST_DIR
	npm install --prefix $BUILD_DIR newrelic@latest
	mkdir -p $BUILD_DIR/node_modules/newrelic-lambda-wrapper
	cp index.js $BUILD_DIR/node_modules/newrelic-lambda-wrapper
	download_extension arm64
	zip -rq $NJS20X_DIST_ARM64 $BUILD_DIR $EXTENSION_DIST_DIR $EXTENSION_DIST_PREVIEW_FILE
	rm -rf $BUILD_DIR $EXTENSION_DIST_DIR $EXTENSION_DIST_PREVIEW_FILE
	echo "Build complete: ${NJS20X_DIST_ARM64}"
}

function build-nodejs20x-x86 {
	echo "Building new relic layer for nodejs20.x (x86_64)"
	rm -rf $BUILD_DIR $NJS20X_DIST_X86_64
	mkdir -p $DIST_DIR
	npm install --prefix $BUILD_DIR newrelic@latest
	mkdir -p $BUILD_DIR/node_modules/newrelic-lambda-wrapper
	cp index.js $BUILD_DIR/node_modules/newrelic-lambda-wrapper
	download_extension x86_64
	zip -rq $NJS20X_DIST_X86_64 $BUILD_DIR $EXTENSION_DIST_DIR $EXTENSION_DIST_PREVIEW_FILE
	rm -rf $BUILD_DIR $EXTENSION_DIST_DIR $EXTENSION_DIST_PREVIEW_FILE
	echo "Build complete: ${NJS20X_DIST_X86_64}"
}


case "$1" in
"build-publish-nodejs16x-ecr-image")
	build-nodejs16x-arm64
	publish_docker_ecr $NJS16X_DIST_ARM64 nodejs16.x arm64
	build-nodejs16x-x86
	publish_docker_ecr $NJS16X_DIST_X86_64 nodejs16.x x86_64
	;;
"build-publish-nodejs18x-ecr-image")
	build-nodejs18x-arm64
	publish_docker_ecr $NJS18X_DIST_ARM64 nodejs18.x arm64
	build-nodejs18x-x86
	publish_docker_ecr $NJS18X_DIST_X86_64 nodejs18.x x86_64
	;;
"build-publish-nodejs20x-ecr-image")
	build-nodejs20x-arm64
	publish_docker_ecr $NJS20X_DIST_ARM64 nodejs20.x arm64
	build-nodejs20x-x86
	publish_docker_ecr $NJS20X_DIST_X86_64 nodejs20.x x86_64
	;;
"nodejs16x")
	$0 build-publish-nodejs16x-ecr-image
	;;
"nodejs18x")
	$0 build-publish-nodejs18x-ecr-image
	;;
"nodejs20x")
	$0 build-publish-nodejs20x-ecr-image
	;;
*)
	usage
	;;
esac