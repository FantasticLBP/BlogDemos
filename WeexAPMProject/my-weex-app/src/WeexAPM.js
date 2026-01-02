/**
 * APM
 */
class WeexAPM {
  /**
   * 获取当前的叶子节点
   * @param {*} Vue vm
   * @returns 当前组件名称
   */
  formatComponentName (vm) {
    if (vm.$root === vm) return 'root'
    var name = vm._isVue
      ? (vm.$options && vm.$options.name) ||
        (vm.$options && vm.$options._componentTag)
      : vm.name
    return (
      (name ? 'component <' + name + '>' : 'anonymous component') +
      (vm._isVue && vm.$options && vm.$options.__file
        ? ' at ' + (vm.$options && vm.$options.__file)
        : '')
    )
  }

  /**
   * 处理Vue错误提示
   */
  monitor (Vue) {
    if (!Vue) {
      return
    }
    // 错误处理
    Vue.config.errorHandler = (err, vm, info) => {
      let componentName = 'unknown'
      if (vm) {
        componentName = this.formatComponentName(vm)
      }
      let errorInfo = {
        name: err.name,
        reason: err.message,
        callStack: err.stack,
        componentName: componentName,
        info: info,
        level: 'VUE_ERROR'
      }
      try {
        const weexAPMUploader = weex.requireModule('weexAPMUploader')
        weexAPMUploader.uploadException(errorInfo)
      } catch (error) {
        console.error('APMMonitor 能力有问题，请检查是否注册了weexAPMUploader模块' + error)
      }
    }
  }
}

export default WeexAPM
