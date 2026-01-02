// Entry.js 完整调试版
import Vue from 'vue'
import weex from 'weex-vue-render'

weex.init(Vue)

const App = require('../../src/components/HelloWorld.vue');
new Vue(Vue.util.extend({el: '#root'}, App));
