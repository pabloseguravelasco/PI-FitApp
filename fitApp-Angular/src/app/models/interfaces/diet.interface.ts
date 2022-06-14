// Generated by https://quicktype.io

export interface DietResponse {
    diet:          Diet[];
    pageable:         Pageable;
    last:             boolean;
    totalPages:       number;
    totalElements:    number;
    size:             number;
    number:           number;
    sort:             Sort;
    first:            boolean;
    numberOfElements: number;
    empty:            boolean;
}

export interface Diet {
    id:         number;
    title:      string;
    ingredient: string;
    calories:   string;
    imagen:     string;
    user:       User;
}

export interface User {
    id:               string;
    nickname:         string;
    email:            string;
    role:             string;
    password:         string;
    avatar:           string;
    listFavDiets:     null;
    listFavExercises: null;
}

export interface Pageable {
    sort:       Sort;
    offset:     number;
    pageSize:   number;
    pageNumber: number;
    unpaged:    boolean;
    paged:      boolean;
}

export interface Sort {
    empty:    boolean;
    sorted:   boolean;
    unsorted: boolean;
}
