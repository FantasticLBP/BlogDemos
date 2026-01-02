<template>
  <div class="wrapper">
    <image :src="logo" class="logo" />
    <text class="greeting">The environment is ready!</text>
    <HelloWorld/>
    <color-button
    title="调用Native Module计算"
    bgColor="#FF6600"
    message=""
    @click="handleButtonClick"
    style="width:400px; height:40px; margin-bottom:20px;"
    ></color-button>
    <text style="font-size: 16px;">乘法结果：{{multiplyResult}}</text>
    <text style="font-size: 16px; margin-bottom: 10px;">加法结果：{{addResult}}</text>
    <color-button
    title="点击模拟 Vue 错误"
    bgColor="#FF6600"
    message=""
    @click="handleVueErrorButtonClick"
    style="width:400px; height:40px; margin-bottom:20px;"
    ></color-button>
    <text>{{ uiscore }}</text>
  </div>
</template>

<script>
import HelloWorld from '@/components/HelloWorld'
import WeexAPM from '@/WeexAPM'
const logicCalculation = weex.requireModule('logicCalculation')

export default {
  name: 'App',
  components: {
    HelloWorld
  },
  data () {
    return {
      multiplyResult: '',
      addResult: '',
      logo: 'https://gw.alicdn.com/tfs/TB1yopEdgoQMeJjy1XaXXcSsFXa-640-302.png',
      score: 100
    }
  },
  computed: {
    uiscore () {
      return this.score.toFixed(2)
    }
  },
  mounted () {
    const Vue = this.$vue || this.$root.constructor

    if (Vue) {
      const weexAPM = new WeexAPM(Vue)
      weexAPM.monitor(Vue)
    } else {
      console.error('Cannot find Vue constructor')
    }
  },
  methods: {
    handleButtonClick () {
      logicCalculation.add(10, 20, (response) => {
        if (response.code === 0) {
          this.addResult = response.result
        } else {
          this.addResult = 'Error in calculation'
        }
      })
      logicCalculation.multiply(10, 20, (response) => {
        if (response.code === 0) {
          this.multiplyResult = response.result
        } else {
          this.multiplyResult = 'Error in multiplication'
        }
      })
    },
    handleVueErrorButtonClick () {
      this.score = '杭城小刘'
    }
  }
}
</script>

<style scoped>
  .wrapper {
    justify-content: center;
    align-items: center;
    background: white;
  }
  .logo {
    width: 424px;
    height: 200px;
  }
  .greeting {
    text-align: center;
    margin-top: 70px;
    font-size: 50px;
    color: #41B883;
  }
  .message {
    margin: 30px;
    font-size: 32px;
    color: #727272;
  }
</style>
