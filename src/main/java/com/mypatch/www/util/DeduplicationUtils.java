package com.mypatch.www.util;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import lombok.extern.log4j.Log4j;
@Log4j
public class DeduplicationUtils {

    /**
     * @param list 중복이 있는 list
     * @param key  중복 여부를 판단하는 키값
     * @param <T>  generic type
     * @return list
     */
    public static <T> List<T> deduplication(final List<T> list, Function<? super T, ?> key) {
        return list.stream()
            .filter(deduplication(key))
            .collect(Collectors.toList());
    }

    private static <T> Predicate<T> deduplication(Function<? super T, ?> key) {
        final Set<Object> set = ConcurrentHashMap.newKeySet();
        return predicate -> set.add(key.apply(predicate));
    }
    
    //List 출력 메서드
    public static <E> void syso(List<E> list){
    	list.forEach(a -> log.info("list 출력: " + a));
    }
    
    //List Date 타입 변환 메서드
    public static <E> List<E> datetrans(List<E> list, Function<? super E, ?> key){
    	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	simpleDateFormat.format(key);
		return list;
    }
    
    //List path 경로 변환 메서드
    public static <E> List<E> pathtrans(List<E> list) {
    	return list;
    }
    
}
