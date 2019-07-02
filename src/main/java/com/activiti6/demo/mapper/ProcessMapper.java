package com.activiti6.demo.mapper;


import java.util.List;
import java.util.Map;

import com.activiti6.demo.model.Definition;
import com.activiti6.demo.model.InstanceViewModel;
import com.activiti6.demo.model.TaskViewModel;
import com.activiti6.demo.viewmodels.PagedFilterViewModel;


/**
 * @Description: 流程任务列表
 * @Author: xiewl
 * @Date: 2018/10/19 15:13
 * @Version 1.0
 */
public interface ProcessMapper {

    /**
     * 流程列表
     */
    List<Definition> getAllFlowList() throws Exception;

    /**
     * 待办列表
     */
    List<TaskViewModel> getDoingTasks(PagedFilterViewModel filter);

    /**
     * 已办列表
     */
    List<InstanceViewModel> getDoneTasks(PagedFilterViewModel filter);

    /**
     * 实例列表
     */
    List<InstanceViewModel> getInstances(PagedFilterViewModel filter);

    /**
     * 执行修改流程实例执行状态
     */
    int modifyProcessState(Map<String, String> params) throws Exception;

    Long getDoingTasksCount(PagedFilterViewModel filter);

    Long getDoneTasksCount(PagedFilterViewModel filter);

    Long getInstancesCount(PagedFilterViewModel filter);
    /**
     * 动态添加流程任务
     */
    Long addRunTask(Map map);

    /**
     * 动态修改流程任务
     */
    Long updateRunTask(Map map);

}
