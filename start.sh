#!/bin/bash

# yuanshikai168 项目 - 快速启动脚本
# 本脚本用于快速启动开发环境

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印函数
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查依赖
check_dependencies() {
    print_info "检查依赖..."
    
    # 检查 Python
    if ! command -v python3 &> /dev/null; then
        print_error "Python 3 未安装"
        exit 1
    fi
    print_success "Python $(python3 --version) ✓"
    
    # 检查 Node.js (可选)
    if command -v node &> /dev/null; then
        print_success "Node.js $(node --version) ✓"
    else
        print_warning "Node.js 未安装 (可选)"
    fi
    
    # 检查 Docker (可选)
    if command -v docker &> /dev/null; then
        print_success "Docker 已安装 ✓"
    else
        print_warning "Docker 未安装 (可选)"
    fi
}

# 安装 Python 依赖
install_python_deps() {
    print_info "安装 Python 依赖..."
    
    if [ -f "requirements.txt" ]; then
        python3 -m pip install --upgrade pip
        python3 -m pip install -r requirements.txt
        print_success "Python 依赖已安装"
    else
        print_warning "requirements.txt 不存在，跳过 Python 依赖安装"
    fi
}

# 安装 Node.js 依赖
install_node_deps() {
    print_info "检查 Node.js 依赖..."
    
    if [ -f "package.json" ]; then
        if command -v npm &> /dev/null; then
            npm install
            print_success "Node.js 依赖已安装"
        else
            print_warning "npm 未安装，跳过 Node.js 依赖"
        fi
    fi
}

# 启动 Docker 容器 (可选)
start_docker() {
    if [ -f "docker-compose.yml" ]; then
        print_info "启动 Docker 容器..."
        docker-compose up -d
        print_success "Docker 容器已启动"
    fi
}

# 运行数据库迁移 (可选)
run_migrations() {
    if [ -f "manage.py" ]; then
        print_info "运行数据库迁移..."
        python3 manage.py migrate || true
    elif [ -f "alembic.ini" ]; then
        print_info "运行数据库迁移 (Alembic)..."
        python3 -m alembic upgrade head || true
    fi
}

# 启动应用
start_app() {
    print_info "启动应用..."
    
    if [ -f "manage.py" ]; then
        print_info "检测到 Django 项目"
        print_info "运行服务器：python manage.py runserver"
        python3 manage.py runserver
    elif [ -f "app.py" ]; then
        print_info "检测到 Flask/FastAPI 项目"
        if grep -q "fastapi" requirements.txt 2>/dev/null; then
            print_info "运行 Uvicorn 服务器..."
            python3 -m uvicorn app:app --reload --host 0.0.0.0 --port 8000
        else
            print_info "运行 Flask 服务器..."
            python3 app.py
        fi
    elif [ -f "main.go" ]; then
        print_info "检测到 Go 项目"
        print_info "编译并运行..."
        go build -o main main.go
        ./main
    elif [ -f "package.json" ]; then
        print_info "检测到 Node.js 项目"
        npm start
    else
        print_warning "未检测到标准应用启动文件"
        print_info "请手动启动应用程序"
    fi
}

# 主函数
main() {
    print_info "====================================="
    print_info "  yuanshikai168 项目 - 快速启动"
    print_info "====================================="
    echo
    
    # 解析命令行参数
    case "${1:-start}" in
        start)
            check_dependencies
            install_python_deps
            install_node_deps
            start_docker
            run_migrations
            start_app
            ;;
        deps)
            check_dependencies
            install_python_deps
            install_node_deps
            print_success "所有依赖已安装"
            ;;
        docker)
            if [ -f "docker-compose.yml" ]; then
                docker-compose up -d
                print_success "Docker 容器已启动"
            else
                print_error "docker-compose.yml 不存在"
            fi
            ;;
        migrate)
            run_migrations
            print_success "数据库迁移完成"
            ;;
        test)
            print_info "运行测试..."
            if [ -f "pytest.ini" ]; then
                python3 -m pytest -v
            elif [ -f "jest.config.js" ]; then
                npm test
            else
                print_warning "未发现测试配置"
            fi
            ;;
        clean)
            print_info "清理缓存..."
            find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
            find . -type d -name "node_modules" -prune -o -type f -name "*.pyc" -delete
            print_success "清理完成"
            ;;
        help|--help|-h)
            cat << EOF
使用方法: ./start.sh [命令]

命令:
  start      启动应用 (默认)
  deps       只安装依赖
  docker     启动 Docker 容器
  migrate    运行数据库迁移
  test       运行测试
  clean      清理缓存
  help       显示此帮助信息

示例:
  ./start.sh              # 启动应用
  ./start.sh deps         # 安装依赖
  ./start.sh docker       # 启动 Docker
  ./start.sh test         # 运行测试
EOF
            ;;
        *)
            print_error "未知命令: $1"
            print_info "使用 './start.sh help' 查看帮助"
            exit 1
            ;;
    esac
    
    echo
    print_success "====================================="
    print_success "操作完成！"
    print_success "====================================="
}

# 处理脚本中断
trap 'print_error "脚本被中断"; exit 1' INT TERM

# 运行主函数
main "$@"
